fun! SetPath()
	set enc=cp949 
	"
	" -------------------------------------------------------------------------------------------------------
	let $SYSTEMPATH="C:/Windows/System32;C:/Windows/Syswow64"
	" =======================================================================================================

	let $GITPATH="C:/Git/bin" 
	let $MERCURIALPATH="C:/Program Files/Mercurial" 
	" -------------------------------------------------------------------------------------------------------
	let $VERMNGPATH="%GITPATH%;%MERCURIALPATH%"
	" =======================================================================================================

	let $PYTHONPATH="C:/Python27;C:/Python27/Lib;C:/Python27/DLLs;C:/Python27/Lib/site-packages;C:/Python27/Scripts"
	let $RUBYPATH="C:/Ruby22/bin"
	let $JAVAPATH="C:/Program Files (x86)/Java/jre7" 
	let $VS10PATH="C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC;C:/Program Files (x86)/Microsoft Visual Studio 10.0/Common7/Tools;C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/bin;C:/Program Files (x86)/Microsoft Visual Studio 10.0/Common7/IDE" 
	" -------------------------------------------------------------------------------------------------------
	let $DEVPATH="%PYTHONPATH%;%RUBYPATH%;%JAVAPATH%;%VS10PATH%"
	" =======================================================================================================

	let $VIMPATH="C:/Vim/Vim74;C:/Vim/ctags58" 
	let $MYUTILS="%HOME%/utils/MyOwn"
	let $GTOOLSPATH="C:/Program Files (x86)/p-nand-q.com/GTools" 
	let $MINGWPATH="C:/MinGW/bin;C:/MinGW/msys/1.0/bin"
	" -------------------------------------------------------------------------------------------------------
	let $UTILSPATH="%VIMPATH%;%MYUTILS%;%GTOOLSPATH%;%MINGWPATH%"
	" =======================================================================================================

	" prefix for MS compile environment

	let $WindowsSdkDir="C:/Program Files/Microsoft SDKs/Windows/v7.1/"

	let windowssdkdir = 'setx WindowsSdkDir "C:/Program Files/Microsoft SDKs/Windows/v7.1/" /M'
	let includepath = 'setx INCLUDE "%WindowsSdkDir%include" /M'
	let lib = 'setx LIB "%WindowsSdkDir%lib" /M'
	let vs100comntools = 'setx VS100COMNTOOLS "D:/Program Files/Microsoft Visual Studio 10.0/Common7/Tools/" /M'

	let ms = windowssdkdir . ' && ' . includepath . '&&' . lib . '&&' . vs100comntools 
	call system(ms)
	" -------------------------------------------------------------------------------------------------------
	" integrate pathes
	let integrate_pathes = 'setx path "%SYSTEMPATH%;%DEVPATH%;%VERMNGPATH%;%UTILSPATH%" /M'
	let msg = system(integrate_pathes)
	echo msg

	set enc=utf8 
	echo '[NOTE] This path will be available when the terminal re-launched.'

endfun
command! SetPath call SetPath()
ca sp SetPath
ca spm e ~/vimfiles/plugin/myvim/setpath.vim

nmap <M-[> :vs<CR>:spm<CR>
