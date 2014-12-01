
#define F_CPU 16000000UL
#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <string.h>  //?? CF

#define TORQUE_buffer_size 100
#define RPM_buffer_size 100

volatile double Time= 0.0;
int TORQUE_rx_1byte =0;
unsigned int RPM_rx_1byte=0;

uint16_t TORQUE_buffer[TORQUE_buffer_size];
uint32_t TORQUE_buffer_head;
uint32_t TORQUE_buffer_tail;
uint8_t TORQUE_rx_data_raw;
uint8_t TORQUE_rx_data_1b[7];
uint16_t TORQUE_rx_data_2b;
double TORQUE_rx_data_4b;
double TORQUE_rx_copy;
///////////////////////////////////////////////////////////////////////////////////////
uint16_t RPM_buffer[RPM_buffer_size];
uint32_t RPM_buffer_head;
uint32_t RPM_buffer_tail;
uint16_t RPM_rx_data_raw;
//uint8_t RPM_rx_data_1b[7];
//uint16_t RPM_rx_data_2b;
double RPM_rx_data_4b;
double RPM_rx_copy;

unsigned char RX0_CHAR(void);
unsigned char RX1_CHAR(void);

void TORQUE_BUFFER_enqueue(uint16_t data);
uint16_t TORQUE_BUFFER_dequeue(void);
void TORQUE_BUFFER_increase_point( uint32_t *data_p);
int TORQUE_BUFFER_is_empty(void);
double TORQUE_get(void);
////////////////////////////////////////////////////////////////////////////////////////
void RPM_BUFFER_enqueue(uint16_t data);
uint16_t RPM_BUFFER_dequeue(void);
void RPM_BUFFER_increase_point( uint32_t *data_p);
int RPM_BUFFER_is_empty(void);
double RPM_get(void);
/////////////////////////////////////////////////////////////
void INIT_TIMERCOUNTER0(void);
void START_TIME();
void WAITING(int n);
void TX1_CHAR(unsigned char data);
static int UART1_PUTCHAR(char c, FILE *stream);
void INIT_UART(void);
/////////////////////////////////////////////////////////////////////////////////////////
void INIT_ADC();
void GET_ADC_DATA();
//void GET_ADC0_DATA();
//void GET_ADC1_DATA();
void INIT_PORT();
void INIT_TIMERCOUNTER1();
void INIT_INTERRUPT();
void INIT_DEVICES();
void INIT_SYSTEM();
double SCALE_LOWPASS_FILTER0(unsigned int data0);
double SCALE_LOWPASS_FILTER1(unsigned int data1);
unsigned int CURRENT_LOWPASS_FILTER(unsigned int data);
double ADC_TO_CURRENT(int data);
unsigned int ADC_TO_WEIGHT();
void SORTuint(unsigned int arr[]);
void SORTd(double arr[]);
void SWAPuint(volatile unsigned int *a, volatile unsigned int *b);
void SWAPd(volatile double *a, volatile double *b);


volatile unsigned int idx_time = 0 ;
volatile unsigned int adc_ch, adc_ch0, adc_ch1, adc_ch2,thrust, weight;
uint16_t adc_init_buf[250];
uint16_t adc_init_buf_trash[250];
uint32_t adc_init_buf_sum = 0;
double adc_init_buf_mean = 0.0;
volatile double current;
volatile double scale0_new = 0.0;
volatile double scale1_new = 0.0;
volatile double scale0_old = 0.0;
volatile double *scale1_old = 0.0;
volatile double current_new = 0.0;
volatile double current_old = 0.0;
volatile unsigned double dT_ms = 15;

//volatile double stau =   0.1; //2.0 ;//1.0 유력
//volatile double sts =   0.01;//0.025 ;
volatile double ctau =   2.0; //2.0 ;//1.0 유력
volatile double cts =   0.025;//0.025 ;
volatile unsigned int cnt_thro=0;
///////////////////////////////////////////////////////////////////////////////////////////////
volatile unsigned int adc_ch0_data[10], adc_ch2_data[10];
volatile double adc_ch1_data[10];
volatile double adc_ch1_sum;
volatile unsigned int  adc_ch0_sum, adc_ch2_sum;
volatile double adc_ch0_mean, adc_ch1_mean, adc_ch2_mean;
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


ISR(TIMER0_OVF_vect){
  TCNT0 = 256-125;
  idx_time++;
}
ISR(INT5_vect){ // PORT E 5 에서 external interrupt 이용
  if(EICRB == ((1<<ISC51)|(1<<ISC50))){
     TCNT1 = 0; //INT5에서 rising edge 인식 후 TCNT1 count 초기화
     //EICRB = 0x08; //falling edge로 변경
     EICRB = (1<<ISC51)|(0<<ISC50);
  }
  else{
     cnt_thro = TCNT1/2; //falling edge로 들어왔을때, cnt_thro 로 count 넘겨줌
     EICRB = 0x0C; //rising edge로 변경
     EICRB = (1<<ISC51)|(1<<ISC50);
  }
}

ISR(USART0_RX_vect){
  TORQUE_rx_1byte = RX0_CHAR();
  TORQUE_BUFFER_enqueue(TORQUE_rx_1byte);
}
ISR(USART1_RX_vect){
  RPM_rx_1byte = RX1_CHAR();
  RPM_BUFFER_enqueue(RPM_rx_1byte);
}

void main(void){
  unsigned char text[]=    "\r\n\t\t USART0 Test \r\n";
  unsigned char i=0;
  for (i=0; i<10; i++){            //adc data buffer
     adc_ch0_data[i] = 0;
     adc_ch1_data[i] = 0.0;
     //adc_ch2_data[i] = 0;
  }
  adc_ch0_mean = adc_ch1_mean =  0.0; // adc_ch2_mean = 0.0;
  adc_ch0_sum = 0;
  adc_ch1_sum = 0.0; //adc_ch2_sum = 0;
  
  double adc_ch_mean = 0.0;
  double ttorq, rrpm;
  
  INIT_SYSTEM();
  i=0;
  while(text[i] != '\0')    TX1_CHAR(text[i++]);
  
  //for(i=0; i<250; i++){
  //GET_ADC_DATA();
  //adc_init_buf_trash[i] = SCALE_LOWPASS_FILTER(adc_ch1, adc_ch2);
  //}
  printf("\t    ADC initialize... \n");
  //for(i=0; i<250; i++){
  ////_delay_ms(100);
  //GET_ADC_DATA();
  //adc_init_buf[i] = SCALE_LOWPASS_FILTER(adc_ch1, adc_ch2);
  //
  //}
  //
  //SORT(adc_init_buf);
  //for(i=0; i<20; i++){
  //adc_init_buf_sum = adc_init_buf_sum + adc_init_buf[i];
  //}
  //adc_init_buf_mean = adc_init_buf_sum / 20.0;
  printf("\t   ADC initialize completed\n");
  /// need to reset signal time delay
  _delay_ms(3000);
  /// need to reset signal time delay
  START_TIME();
  while(1){

     WAITING(dT_ms);
     Time += dT_ms/1000.0;
     //for(i=0; i<10; i++){
        //GET_ADC_DATA();
        //adc_ch0_data[i] = CURRENT_LOWPASS_FILTER(adc_ch0);
        //adc_ch1_data[i] = SCALE_LOWPASS_FILTER(adc_ch1, adc_ch2);
     //}
     //SORTuint(adc_ch0_data);               //ch0 : current sensor
     //SORTd(adc_ch1_data);               //ch1 : scale
     //
     //adc_ch0_sum =0.0;
     //adc_ch1_sum =0;
     //for(i=2; i<8;i++){
        //adc_ch0_sum = adc_ch0_sum + adc_ch0_data[i];
        //adc_ch1_sum = adc_ch1_sum + adc_ch1_data[i];
     //}
     //adc_ch0_mean = adc_ch0_sum / 6.0;
     //adc_ch1_mean = adc_ch1_sum / 6.0;
     ////adc_ch2_mean = adc_ch2_sum / 6.0;
     //printf("T, C, S : %5.2f,  %5.2f , %5.2f\n",Time, adc_ch0_mean, adc_ch1_mean - adc_init_buf_mean);
     //
     //if ((int) Time == 15){
        //adc_init_buf_mean = adc_ch1_mean;
     //}
     
/////////////////////////////////////////////////////////////////////////////////////////////
     GET_ADC_DATA();
     
     adc_ch0_mean = SCALE_LOWPASS_FILTER0(adc_ch1);
     adc_ch2_mean = SCALE_LOWPASS_FILTER1(adc_ch2);
     
     //for(i=0; i < 10 ; i++){
        //GET_ADC_DATA();
        //adc_ch0_data[i] = adc_ch1;
        //adc_ch2_data[i] = adc_ch2;
     //}
     //SORTuint(adc_ch0_data);
     //SORTuint(adc_ch2_data);
     //adc_ch0_sum = 0;
     //adc_ch2_sum = 0;
     //for(i=3; i<7; i++){
        //adc_ch0_sum = adc_ch0_sum + adc_ch0_data[i];
        //adc_ch2_sum = adc_ch2_sum + adc_ch2_data[i];
     //}
     //adc_ch0_mean = adc_ch0_sum / 4.0;
     //adc_ch2_mean = adc_ch2_sum / 4.0;
     //
     //printf("%5.2f %4d %4d \n", Time, adc_ch1, adc_ch2);
     printf("%5.2f %5d %6.2f %5d %6.2f %6.2f\n",Time, adc_ch1, adc_ch0_mean, adc_ch2,adc_ch2_mean, (adc_ch0_mean+adc_ch2_mean)/2.0);
     //////////////////////////////////////////////////////////
     if (RPM_rx_1byte == '!')         //reset
     {
        PORTG = 0x00;
        _delay_ms(100);
        PORTG = 0x08;
     }
     if (RPM_rx_1byte == '@'){
        DDRG = 0x00;
     }
     if (RPM_rx_1byte == '#'){
        DDRG = 0x08;
     }
     ///////////////////////////////////////////////////////////

  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void TORQUE_BUFFER_increase_point( uint32_t *data_p){
  (*data_p)++;
  if((*data_p) == TORQUE_buffer_size)
  (*data_p) = 0;
}

void TORQUE_BUFFER_enqueue(uint16_t data){
  TORQUE_buffer[TORQUE_buffer_head] = data;
  TORQUE_BUFFER_increase_point(&TORQUE_buffer_head);
}

uint16_t TORQUE_BUFFER_dequeue(void){
  uint16_t retval = TORQUE_buffer[TORQUE_buffer_tail];
  TORQUE_BUFFER_increase_point(&TORQUE_buffer_tail);
  return retval;
}

int TORQUE_BUFFER_is_empty(void){
  if(TORQUE_buffer_head == TORQUE_buffer_tail)
  return 1;

  return 0;

}
double TORQUE_get(void){
  if(TORQUE_BUFFER_is_empty() ==0){
     if(TORQUE_BUFFER_dequeue() == '+'){
        TORQUE_BUFFER_dequeue();
        //TORQUE_BUFFER_dequeue();
        //for(int i=0; i<4 ; i++){
        //TORQUE_rx_data_raw = TORQUE_BUFFER_dequeue();
        //if(i==2) TORQUE_BUFFER_dequeue();
        //TORQUE_rx_data_1b[i] = TORQUE_rx_data_raw-48;
        //if(i==0)        TORQUE_rx_data_2b  = TORQUE_rx_data_1b[i] * 1000;
        //else if(i==1)   TORQUE_rx_data_2b += TORQUE_rx_data_1b[i] * 100;
        //else if(i==2)   TORQUE_rx_data_2b += TORQUE_rx_data_1b[i] * 10;
        //else if(i==3)   TORQUE_rx_data_2b += TORQUE_rx_data_1b[i] * 1;
        //}
        for(int i=0; i<5 ; i++){
           TORQUE_rx_data_raw = TORQUE_BUFFER_dequeue();
           if(i==3) TORQUE_BUFFER_dequeue();
           TORQUE_rx_data_1b[i] = TORQUE_rx_data_raw-48;
           if(i==0)        TORQUE_rx_data_2b  = TORQUE_rx_data_1b[i] * 10000;
           else if(i==1)   TORQUE_rx_data_2b += TORQUE_rx_data_1b[i] * 1000;
           else if(i==2)   TORQUE_rx_data_2b += TORQUE_rx_data_1b[i] * 100;
           else if(i==3)   TORQUE_rx_data_2b += TORQUE_rx_data_1b[i] * 10;
           else if(i==4)   TORQUE_rx_data_2b += TORQUE_rx_data_1b[i] * 1;
        }

     }
  }
  //printf("%d \n", TORQUE_rx_data_2b);
  TORQUE_rx_data_4b = TORQUE_rx_data_2b/10.0;
  if (TORQUE_rx_data_4b >= 2500){         //saturation point 2000;;
     TORQUE_rx_data_4b = TORQUE_rx_copy;
  }
  TORQUE_rx_copy = TORQUE_rx_data_4b;
  return TORQUE_rx_data_4b;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void RPM_BUFFER_increase_point( uint32_t *data_p){
  (*data_p)++;
  if((*data_p) == RPM_buffer_size)
  (*data_p) = 0;
}

void RPM_BUFFER_enqueue(uint16_t data){
  RPM_buffer[RPM_buffer_head] = data;
  RPM_BUFFER_increase_point(&RPM_buffer_head);
}

uint16_t RPM_BUFFER_dequeue(void){
  uint16_t retval = RPM_buffer[RPM_buffer_tail];
  RPM_BUFFER_increase_point(&RPM_buffer_tail);
  return retval;
}

int RPM_BUFFER_is_empty(void){
  if(RPM_buffer_head == RPM_buffer_tail)
  return 1;

  return 0;
}

double RPM_get(void){
  if(RPM_BUFFER_is_empty() ==0){
     RPM_rx_data_raw = RPM_BUFFER_dequeue();
  }
  RPM_rx_data_4b = RPM_rx_data_raw * 100;      //unit trans
  return RPM_rx_data_4b;
}

// double RPM_get(void){
//       if(RPM_BUFFER_is_empty() ==0){
//          RPM_rx_data_raw = RPM_BUFFER_dequeue();
//       }
//       if ((RPM_rx_data_raw - RPM_rx_copy) >= 200){
//          RPM_rx_data_raw = RPM_rx_data_raw + 255;
//       }
//       if (RPM_rx_data_raw<280){
//          RPM_rx_copy = RPM_rx_data_raw;
//          RPM_rx_data_4b =  RPM_rx_copy;
//       }
//       return RPM_rx_data_4b;
//    }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void TX1_CHAR(unsigned char data){
  while((UCSR1A & 0x20)==0);
  UDR1 = data;
  UCSR1A |= 0x20;
}

static int UART1_PUTCHAR(char c, FILE *stream){
  if(c == '\n')
  UART1_PUTCHAR('\r', stream);
  while(!(UCSR1A & (1<<UDRE1)));   // UDRE0==1 ?易走?? ?╱﹉??５???
  // ????╱????Ｘ loop_until_bit_is_set(UCSR0A, UDRE0); ?Ｘ ?﹉Ｔ??５.
  UDR1 = c;

  return 0;
}
static FILE mystdout = FDEV_SETUP_STREAM(UART1_PUTCHAR, NULL, _FDEV_SETUP_WRITE);

unsigned char RX0_CHAR(){
  unsigned char data;
  while((UCSR0A & 0x80) == 0);
  data = UDR0;
  return data;
}
unsigned char RX1_CHAR(){
  unsigned char data;
  while((UCSR1A & 0x80) == 0);
  data = UDR1;
  return data;
}
/////////////////////////////////////////////////////////////////////////////////
void INIT_TIMERCOUNTER0(void){
  TCCR0 = (0<<WGM01 | 0<<WGM00);                     // normal mode   // 62.5 * 10^-9 *128 = 0.000008 ,  0.000008 * 125 = 0.001 -> 1ms
  TCNT0 = 256-125;                                       // 1ms ?╳▼????╞ OVERFLOW INT ?╳芋?????
  TCCR0 |= (1<<CS02 | 0<<CS01 | 1<<CS00);               // TC2 start (??????“?128)
  TIMSK = (1<<TOIE0);                                    // OVERFLOW2 INT enable
}
void INIT_TIMERCOUNTER1(void){
  TCCR1A = (1<<WGM11);                                  // fast PWM mode set, '''''0b00000010;
  TCCR1B = (1<<WGM13)|(1<<WGM12)| (1<<CS11);          //0b00011010;
  ICR1 = 40000;                                           //20msec period
}

void INIT_INTERRUPT(void){
  //EICRA -> INT0 : rising edge sensing(ISC0n = 11), INT1 : falling edge sensing(ISC1n = 10)
  //EICRA = (1<<ISC01)|(1<<ISC00); //External interrupt sense control
  //EIMSK = (1<<INT0); // set bits INT1, INT0
  //sei();
  //SREG |=0x80;               // all interrupt set (  sei() )
  EIMSK = (1<<INT5);    // INT0, 1, 4, 5 외부인터럽트 개별 허용
  //EICRA = 0b00001111;    // INT0, 1 - rising edge 트리거 설정
  EICRB = 0b00001100;    // INT4, 5 - rising edge 트리거 설정
}

void INIT_ADC(void){
  //ADMUX = (0<<REFS1| 0<<REFS0 | 0<<ADLAR);      //save from right
  ADMUX = (0<<ADLAR);
  ADCSRA = (1<<ADEN | 0 <<ADFR | 0<<ADIE | 1<<ADPS2 | 1<<ADPS1 | 1<<ADPS0);   //ADC Perscaler select , 128 = 125kHz
  
}

void START_TIME(){
  idx_time = 0;
}

void WAITING(int n){
  while(1){
     if(idx_time == n){
        START_TIME();
        break;
     }
  }
}
void SORTuint(unsigned int arr[]){
  int i, j;
  for (i=0; i<10; i++){
     for (j=i+1; j<11; j++){
        if (arr[i] > arr[j])
        SWAPuint(&arr[i], &arr[j]);
     }
  }
}
void SORTd(double arr[]){
  int i, j;
  for (i=0; i<10; i++){
     for (j=i+1; j<11; j++){
        if (arr[i] > arr[j])
        SWAPd(&arr[i], &arr[j]);
     }
  }
}
void SWAPuint(volatile unsigned int *a, volatile unsigned int *b){
  volatile unsigned int tmp=*a;
  *a=*b;
  *b=tmp;
}
void SWAPd(volatile double *a, volatile double *b){
  volatile double tmp=*a;
  *a=*b;
  *b=tmp;
}
void INIT_UART(void){
  // USART0 = PORT E = TORQUE sensor indicator(RS-232c)
  // USART1 = PORT D = RPM MEASURE(TTL) + PC(RS-232c)

  UCSR0A = 0x00;                           //TORQUE sensor indicator(RS-232c)
  UCSR0B = (1<<RXCIE0) | (1<<RXEN0);       //  RX complete interrupt enable  , receiver enable
  UCSR0C = (1<<UCSZ01) | (1<<UCSZ00);    //Asynchronous mode, no parity mode, 1stop bit
  UBRR0H = 0x00;
  UBRR0L = 0x67;                            //TORQUE sensor baud rate 9600 bps UBBR  : 103 = 0x67

  UCSR1A = 0x00;                                          //RPM MEASURE(TTL) + PC(RS-232c)
  UCSR1B = (1<<RXCIE1) | (1<< TXEN1) |(1<<RXEN1);      //  RX complete interrupt enable  , receiver//Transmitter enable
  UCSR1C = (1<<UCSZ11) | (1<<UCSZ10);                   //Asynchronous mode, no parity mode, 1stop bit
  UBRR1H = 0x00;
  UBRR1L = 0x08;                                           //PC, RPM measure baud rate 115200 bps UBBR : 8 = 0x08
}

//void GET_ADC0_DATA(){
//unsigned char i;
//adc_ch0 = 0;
//for(i=0; i<16; i++){
//ADCSRA &= ~(1<<ADEN);            // ADC disable
//ADMUX  = (0<<MUX4 | 0<<MUX3 | 0<<MUX2 | 0<<MUX1 | 0<<MUX0);   //PF0   // current sensor
//ADMUX |= (0<<REFS1 | 1<< REFS0);
//ADCSRA |= (1<<ADEN | 1<<ADSC);      // ADC enable & start
//while((ADCSRA & 0x10) != 0x10);
//adc_ch0 = ADC;
//}
//}
//
//void GET_ADC1_DATA(){
//unsigned char i;
//adc_ch1=0;
//for(i=0; i<16; i++){
//ADCSRA &= ~(1<<ADEN);            // ADC disable
//ADMUX  = (0<<MUX4 | 0<<MUX3 | 0<<MUX2 | 0<<MUX1 | 1<<MUX0);   //PF0   // current sensor
//ADMUX |= (0<<REFS1 | 0<< REFS0);
//ADCSRA |= (1<<ADEN | 1<<ADSC);      // ADC enable & start
//while((ADCSRA & 0x10) != 0x10);
//adc_ch1 = ADC;
//}
//}


void GET_ADC_DATA(){
  unsigned char i;
  adc_ch0 = adc_ch1 = adc_ch2 = 0;
  for(i=0;i<16;i++){      // terminal delay

     ADCSRA &= ~(1<<ADEN);            // ADC disable
     ADMUX  = (0<<MUX4 | 0<<MUX3 | 0<<MUX2 | 0<<MUX1 | 0<<MUX0);   //PF0   // current sensor
     ADMUX |= (0<<REFS1 | 1<< REFS0);
     ADCSRA |= (1<<ADEN | 1<<ADSC);      // ADC enable & start
     while((ADCSRA & 0x10) != 0x10);
     adc_ch0 = ADC;

     ADCSRA &= ~(1<<ADEN);            // ADC disable
     ADMUX  = (0<<MUX4 | 0<<MUX3 | 0<<MUX2 | 0<<MUX1 | 1<<MUX0);   //PF1   //scale line blue
     ADMUX |= (0<<REFS1 | 0<< REFS0);
     ADCSRA |= (1<<ADEN | 1<<ADSC);      // ADC enable & start
     while((ADCSRA & 0x10) != 0x10);
     adc_ch1 = ADC;

     ADCSRA &= ~(1<<ADEN);            // ADC disable
     ADMUX  = (0<<MUX4 | 0<<MUX3 | 0<<MUX2 | 1<<MUX1 | 0<<MUX0);   //PF1   //scale line white
     ADMUX |= (0<<REFS1 | 0<< REFS0);
     ADCSRA |= (1<<ADEN | 1<<ADSC);      // ADC enable & start
     while((ADCSRA & 0x10) != 0x10);
     adc_ch2 = ADC;
  }

}
void INIT_PORT(){
  DDRF = 0x00;      //ADC port
  ////////////interrupt capture ISR /////////
  DDRE = 0b00000010;                  // INT 4, 5 Receive
  PORTE = 0b00110000;                  // INT 4, 5 inner pullup resister
  DDRD = 0x08;                        //PD2 : UART1 receive(0) , PD3 : UART1 transmit(1).
  DDRG = 0x08;
  PORTG = 0x08;
}

void INIT_DEVICES(){
  cli();                     //disable all interrutps
  INIT_UART();
  INIT_PORT();
  INIT_TIMERCOUNTER0();
  INIT_TIMERCOUNTER1();
  INIT_INTERRUPT();
  INIT_ADC();
  sei();                     //enable all interrupts
}
void INIT_SYSTEM(){
  INIT_DEVICES();
  stdout = &mystdout;            // to use the printf function
  _delay_ms(10);                  // to stabilize the system
}

double SCALE_LOWPASS_FILTER0( unsigned int data0){
    double stau = 1.5;
    //double sts = dT_ms/1000;
    double sts = 0.015;
     scale0_new = (double)  (stau/(stau+sts)) *scale0_old + (sts/(stau+sts)) * data0;
     scale0_old = scale0_new;
     
     return scale0_old;
}
double SCALE_LOWPASS_FILTER1(unsigned int data1){
    double stau = 1.5;
    double sts = dT_ms/1000;
    scale1_new =  (double) (stau/(stau+sts)) *scale1_old + (sts/(stau+sts)) * data1;
    scale1_old = scale1_new;

    return scale1_old;
 }
     
unsigned int CURRENT_LOWPASS_FILTER(unsigned int data){
  current_new = (double)  (ctau/(ctau+cts)) *current_old + (cts/(ctau+cts)) * data;
  current_old = current_new;
  return (unsigned int) current_new;
}

//double ADC_TO_CURRENT (int data){
//current = (double)  7.7 - (896 - data)*(7.7-1.0)/(896-543);
//return current;
//}
//
//unsigned int ADC_TO_WEIGHT (double data){
//
//unsigned int a=0;
//a = (unsigned int) (data-0.0);
//
//if (a <= 1)    a = 0;
//
//weight = a*1.0;
//
//// if (weight < 80)
//// weight = 0;
//
//return weight;
//}

