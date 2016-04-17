                                                  ::::::::::::::::::::::::::::::::::::::::::::::::: 
                                                   :::::::::::::::::::::JaspR:::::::::::::::::::::
                                                    ::  Just Another Software to Pull Rubbish  ::
                                                     :::::::::::::::::::::::::::::::::::::::::::
                                                     ::  Programme créé par Raphaël BERTEAUD  ::
                                                     :: Lien : http://draftik.github.io/jaspr ::
                                                     ::   Contact : raph.berteaud@gmail.com   ::
                                                     :::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                    ------------------------------ Creative Commons ------------------------------                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                      Ce code a été créé par Raphaël BERTEAUD, il est protégé sous la licence :                                       ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                             Creative Commons : CC-BY-NC                                                              ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Cela signifie que VOUS POUVEZ :                                                                                                                      ::
:: - EXECUTER,                                                                                                                                          ::
:: - MODIFIER,                                                                                                                                          ::
:: - et REDISTRIBUER                                                                                                                                    ::
:: ce programme,                                                                                                                                        ::
::                                                                                                                                                      ::
:: UNIQUEMENT A CONDITION :                                                                                                                             ::
:: - de CITER SON AUTEUR (Raphaël BERTEAUD),                                                                                                            ::
:: - et de NE PAS PUBLIER CE CODE A DES FINS LUCRATIVES SANS AUTORISATION DE L'AUTEUR.                                                                  ::
::                                                                                                                                                      ::
:: Commande externe utilisée :                                                                                                                          ::
:: -[C#] AGRAFV2.exe :                                                                                                                                  ::
::      Lien de téléchargement : http://batch.xoo.it/t5092-C-DEV-AgrafV2-Cr-ateur-d-interface-graphique-TSnake41.htm                                    ::
::      Auteur : TSnake41 (http://batch.xoo.it/profile.php?mode=viewprofile&u=3022)                                                                     ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                    ------------------------------ Creative Commons ------------------------------                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off

::VERIFICATION DE L'EXECUTION EN TANT QU'ADMINISTRATEUR
net session >nul 2>nul
	if errorlevel 1 (
		echo msgbox "Fatal : not_admin" ^& vbcrlf ^& "Code : 16x01" ^& vbcrlf ^& vbcrlf ^& vbcrlf ^& "Description : Not administrator !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\adminRor.vbs"
		"%tmp%\adminRor.vbs"
		del /f /q "%tmp%\adminRor.vbs" >nul 2>nul
		exit
	)

::PARAMETRES DE LA CONSOLE
title JaspR
mode con cols=66 lines=13
echo Initialisation de JaspR, veuillez patienter...

::CREATION DU DOSSIER LOCAL JASPR
set jpath=%localappdata%\JaspR
if not exist "%jpath%" md "%jpath%" >nul 2>nul

::VERIFICATION DE VERSION
	if exist "%jpath%\ver.ini" (
		for /f "tokens=1 delims=;" %%i in (%jpath%\ver.ini) do set jaspr_version=%%i
		echo 110; >"%jpath%\ver.ini"
	) else (
		set jaspr_version=100
		echo 110; >"%jpath%\ver.ini"
	)
	if %jaspr_version% lss 110 (
		del /f /q /s "%jpath%" >nul 2>nul
		rd /q /s "%jpath%" >nul 2>nul
	)
	if not exist "%jpath%" md "%jpath%" >nul 2>nul
	
echo 110; >"%jpath%\ver.ini"

::COPIE DE AGRAFV2
	if not exist "%windir%\system32\AgrafV2.exe" (
	for /f "tokens=*" %%a in ('dir /s /b /a-d "%~dp0" ^|find /i "agrafv2.exe"') do set local_agraf=%%a & goto test_local_agraf
:test_local_agraf
		if exist "%local_agraf%" (
			set agraf_path=%local_agraf%
			copy "%local_agraf%" "%windir%\system32\" /y >nul 2>nul
				if not exist "%windir%\system32\AgrafV2.exe" (
					copy "%local_agraf%" "%jpath%\" /y >nul 2>nul
						if exist "%jpath%\AgrafV2.exe" (						
							set agraf_path=%jpath%\AgrafV2.exe
						)
				) else (
					set agraf_path=%windir%\system32\AgrafV2.exe
				)
		) else (
			echo msgbox "Fatal : dependency_error" ^& vbcrlf ^& "Code : 16x02" ^& vbcrlf ^& vbcrlf ^& "Description : AgrafV2 not found !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\agrafRor.vbs"
			"%tmp%\agrafRor.vbs"
			del /f /q "%tmp%\agrafRor.vbs" >nul 2>nul
			exit
		)
	) else (
		set agraf_path=%windir%\system32\AgrafV2.exe
	)

::COPIE DE L'ICÔNE
	if not exist "%jpath%\JaspRico.ico" (
		if exist "%~dp0\JaspRico.ico" (
			copy "%~dp0\JaspRico.ico" "%jpath%" /y >nul 2>nul
		)
	)

::COPIE DE L'AIDE
	if not exist "%jpath%\help" md "%jpath%\help"
	
	if not exist "%jpath%\help\help.html" (
		if exist "%~dp0\help\help.html" (
		copy "%~dp0\help\help.html" "%jpath%\help" /y >nul 2>nul
		)
	)
	
	if not exist "%jpath%\help\help_files" (
		if exist "%~dp0\help\help_files" (
			md "%jpath%\help\help_files"
			xcopy "%~dp0\help\help_files" "%jpath%\help\help_files" /e /h /c /y >nul 2>nul
		)
	)

::COPIE DU SUPPORT MULTI-LANGAGE
	if not exist "%jpath%\lang" md "%jpath%\lang"
	
	if not exist "%jpath%\lang\eng.lang" (
		if exist "%~dp0\lang\eng.lang" (
			copy "%~dp0\lang\eng.lang" "%jpath%\lang\" /y >nul 2>nul
		)
	)
	if not exist "%jpath%\lang\fra.lang" (
		if exist "%~dp0\lang\fra.lang" (
			copy "%~dp0\lang\fra.lang" "%jpath%\lang\" /y >nul 2>nul
		)
	)
	if not exist "%jpath%\lang\pref.ini" (
		echo eng;>"%jpath%\lang\pref.ini"
	)
		
for /f "tokens=1 delims=;" %%i in (%jpath%\lang\pref.ini) do set lang_pref=%%i
	if not "%lang_pref%"=="fra" (
		if not "%lang_pref%"=="eng" (
			set lang_pref=eng
			set jlangpath=%jpath%\lang\eng.lang
			echo eng;>"%jpath%\lang\pref.ini"
		) else (
				if exist "%jpath%\lang\eng.lang" (
					set jlangpath=%jpath%\lang\eng.lang
				)
		)
	) else (
			if exist "%jpath%\lang\fra.lang" (
				set jlangpath=%jpath%\lang\fra.lang
			)
	
	)

::VARIABLE DU DOSSIER DES UTILISATEURS
for /f "tokens=2-3 delims=\" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^|find /i "Common AppData"') do set users_dir=%systemdrive%\%%a
	if not "%users_dir%"=="%systemdrive%\Documents and Settings" set users_dir=%systemdrive%\Users

::VERIFICATION ET COPIE DU CODE SOURCE
set jext=%~x0
set jname=%~n0
set jfullpath=%~f0
	if "%jext%"==".exe" (
	for /f "tokens=*" %%s in ('dir /s /b /a-d "%tmp%\*%jname:~0,5%*.bat" 2^>nul') do set tmp_source_code=%%s & goto test_tmp_source
:test_tmp_source
		if defined tmp_source_code (
			if exist "%tmp_source_code%" (
				set jfullpath=%tmp_source_code%
			) else (
				echo msgbox "Fatal : no_source_code" ^& vbcrlf ^& "Code : 16x03" ^& vbcrlf ^& vbcrlf ^& "Descripiton : The source code was not found !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\tmpsrcRor.vbs"
				"%tmp%\tmpsrcRor.vbs"
				del /f /q "%tmp%\tmpsrcRor.vbs" >nul 2>nul
				exit
			)
		) else (
			echo msgbox "Fatal : no_source_code" ^& vbcrlf ^& "Code : 16x04" ^& vbcrlf ^& vbcrlf ^& "Descripiton : The source code was not found !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\tmpsrcRor.vbs"
			"%tmp%\tmpsrcRor.vbs"
			del /f /q "%tmp%\tmpsrcRor.vbs" >nul 2>nul
			exit
		)
	)
copy /y "%jfullpath%" "%jpath%" >nul 2>nul
	if not exist "%jpath%\*%jname:~0,5%*.bat" (
		echo msgbox "Fatal : no_source_code" ^& vbcrlf ^& "Code : 16x05" ^& vbcrlf ^& vbcrlf ^& "Descripiton : The source code was not found !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\tmpsrcRor.vbs"
		"%tmp%\tmpsrcRor.vbs"
		del /f /q "%tmp%\tmpsrcRor.vbs" >nul 2>nul
		exit
	) else (
		ren "%jpath%\*%jname:~0,5%*.bat" "%jname:~0,5%.bat" >nul 2>nul
	)

::DEFINITION DES CONSTANTES
set jfullpath=%jpath%\%jname:~0,5%.bat
set localchromedir=%localappdata%\Google\Chrome\User Data
set localfirefoxdir=%localappdata%\Mozilla\Firefox\Profiles
set roamingfirefoxdir=%appdata%\Mozilla\Firefox\Profiles
for /f "tokens=*" %%o in ('dir /b /ad "%appdata%" ^|findstr /i opera') do set roamingoperadir=%appdata%\%%o
for /f "tokens=*" %%o in ('dir /b /ad "%localappdata%" ^|findstr /i opera') do set localoperadir=%localappdata%\%%o
set localhistorysafaridir=%localappdata%\Applec~1\Safari\History
set localsafaridir=%localappdata%\Applec~1\Safari
set roamingsafaridir=%appdata%\Applec~1
set localIEdir=%localappdata%\Microsoft\Intern~1
set localhistoryIEdir=%localappdata%\Microsoft\Windows\History
set localtempIEdir=%localappdata%\Microsoft\Windows\Tempor~1
set roamingcookiesIEdir=%appdata%\Microsoft\Windows\Cookies
set tempbool=TRUE
set trashbool=TRUE
set recentbool=TRUE
set winlogbool=TRUE
set thumbbool=TRUE
set prefetchbool=TRUE
set hiberbool=FALSE
set nonavbool=FALSE
set yesnavbool=TRUE
	if exist "%localfirefoxdir%" (
		set firefoxbool=TRUE
	) else (
		set firefoxbool=FALSE
	)
	if exist "%localchromedir%" (
		set chromebool=TRUE
	) else (
		set chromebool=FALSE
	)
	if exist "%localappdata%\Packages\Microsoft.MicrosoftEdge*" (
		set edgebool=TRUE
	) else (
		set edgebool=FALSE
	)
set iexplorebool=TRUE
	if exist "%localsafaridir%" (
		set safaribool=TRUE
	) else (
		set safaribool=FALSE
	)
	if exist "%localoperadir%" (
		set operabool=TRUE
	) else (
		set operabool=FALSE
	)


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::PROGRAMME:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:start_cl_tool
cls   
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³       Just Another Software to Pull Rubbish       ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
echo.
echo.

::CREATION DU RAPPORT (VIDE)
copy nul "%jpath%\JaspR.log" /y >nul 2>nul

::REMISE A ZERO DE TOUTES LES VARIABLES
set tempfiles=0
set /a cl_temp_size=0
set emptytrash=0
set /a cl_trash_size=0
set recentfiles=0
set /a cl_recent_size=0
set logwindows=0
set /a cl_winlog_size=0
set thumbcache=0
set /a cl_thumb_size=0
set prefetch=0
set /a cl_prefetch_size=0
set hiberstate=0
set /a hiberfilsize=0
set yes_clean_nav=0
set no_clean_nav=0
set cl_firefox=0
set /a cl_firefox_size=0
set cl_chrome=0
set /a cl_chrome_size=0
set cl_edge=0
set /a cl_edge_size=0
set cl_iexplore=0
set /a cl_iexplore_size=0
set cl_safari=0
set /a cl_safari_size=0
set cl_opera=0
set /a cl_opera_size=0
set back=0
set analyse=0
set confirm_clean=0
set settings=0
set help=0
	if "%jlangpath%"=="%jpath%\lang\eng.lang" (
		set lang_en_state=TRUE
		set lang_fr_state=FALSE
	) else (
			if "%jlangpath%"=="%jpath%\lang\fra.lang" (
				set lang_en_state=FALSE
				set lang_fr_state=TRUE
			) else (
					if "%jlangpath%"=="" (
						set jlangpath=%jpath%\lang\eng.lang
						set lang_en_state=TRUE
						set lang_fr_state=FALSE
					)
			)
	)
	if not exist "%jlangpath%" (
		set jlangpath=%jfullpath%
	)
::APPEL DE LA GUI (MENU PRINCIPAL)
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jlangpath%" #cl_mainwi
) else (
call :resultgui "%jlangpath%" #cl_main
)

::PROGRESSBAR INITIALE SUR LA CONSOLE
	if %settings% equ 1 (
		echo.
	) else (
		if %help% equ 1 (
			echo.
		) else (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³                        0%%                        ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
			echo.
		)
	)

::CONDITIONS ET FONCTIONS A APPELER
	if %confirm_clean% equ 1 (
		if %tempfiles% equ 1 ( set tempbool=TRUE & call :tempclean ) else ( set tempbool=FALSE )
		if %emptytrash% equ 1 ( set trashbool=TRUE & call :trashclean ) else ( set trashbool=FALSE )
		if %recentfiles% equ 1 ( set recentbool=TRUE & call :recentfileslistclean ) else ( set recentbool=FALSE )
		if %logwindows% equ 1 ( set winlogbool=TRUE & call :logwindowsclean ) else ( set winlogbool=FALSE )
		if %thumbcache% equ 1 ( set thumbbool=TRUE & call :thumbcacheclean ) else ( set thumbbool=FALSE )
		if %prefetch% equ 1 ( set prefetchbool=TRUE & call :prefetchclean ) else ( set prefetchbool=FALSE )
		if %hiberstate% equ 1 (
			set hiberbool=TRUE
			call :hiberoff
		) else (
			set hiberbool=FALSE
			if not exist "%systemdrive%\hiberfil.sys" powercfg /h on >nul 2>nul
		)
		if %no_clean_nav% equ 1 (
			set nonavbool=TRUE
			set yesnavbool=FALSE
			if %cl_firefox% equ 1 ( set firefoxbool=TRUE ) else ( set firefoxbool=FALSE )
			if %cl_chrome% equ 1 ( set chromebool=TRUE ) else ( set chromebool=FALSE )
			if %cl_edge% equ 1 ( set edgebool=TRUE ) else ( set edgebool=FALSE )
			if %cl_iexplore% equ 1 ( set iexplorebool=TRUE ) else ( set iexplorebool=FALSE )
			if %cl_safari% equ 1 ( set safaribool=TRUE ) else ( set safaribool=FALSE )
			if %cl_opera% equ 1 ( set operabool=TRUE ) else ( set operabool=FALSE )			
			set cl_firefox=0
			set cl_chrome=0
			set cl_edge=0
			set cl_iexplore=0
			set cl_safari=0
			set cl_opera=0
		) else (
			set nonavbool=FALSE
			set yesnavbool=TRUE
			if %cl_firefox% equ 1 ( set firefoxbool=TRUE & call :cl_firefox ) else ( set firefoxbool=FALSE )
			if %cl_chrome% equ 1 ( set chromebool=TRUE & call :cl_chrome ) else ( set chromebool=FALSE )
			if %cl_edge% equ 1 ( set edgebool=TRUE & call :cl_edge ) else ( set edgebool=FALSE )
			if %cl_iexplore% equ 1 ( set iexplorebool=TRUE & call :cl_iexplore ) else ( set iexplorebool=FALSE )
			if %cl_safari% equ 1 ( set safaribool=TRUE & call :cl_safari ) else ( set safaribool=FALSE )
			if %cl_opera% equ 1 ( set operabool=TRUE & call :cl_opera ) else ( set operabool=FALSE )
		)
	)
	if %analyse% equ 1 (
		if %tempfiles% equ 1 ( set tempbool=TRUE & call :tempclean ) else ( set tempbool=FALSE )
		if %emptytrash% equ 1 ( set trashbool=TRUE & call :trashclean ) else ( set trashbool=FALSE )
		if %recentfiles% equ 1 ( set recentbool=TRUE & call :recentfileslistclean ) else ( set recentbool=FALSE )
		if %logwindows% equ 1 ( set winlogbool=TRUE & call :logwindowsclean ) else ( set winlogbool=FALSE )
		if %thumbcache% equ 1 ( set thumbbool=TRUE & call :thumbcacheclean ) else ( set thumbbool=FALSE )
		if %prefetch% equ 1 ( set prefetchbool=TRUE & call :prefetchclean ) else ( set prefetchbool=FALSE )
		if %hiberstate% equ 1 (
			set hiberbool=TRUE
			call :hiberoff
		) else (
			set hiberbool=FALSE
		)
		if %no_clean_nav% equ 1 (
			set nonavbool=TRUE
			set yesnavbool=FALSE
			if %cl_firefox% equ 1 ( set firefoxbool=TRUE ) else ( set firefoxbool=FALSE )
			if %cl_chrome% equ 1 ( set chromebool=TRUE ) else ( set chromebool=FALSE )
			if %cl_edge% equ 1 ( set edgebool=TRUE ) else ( set edgebool=FALSE )
			if %cl_iexplore% equ 1 ( set iexplorebool=TRUE ) else ( set iexplorebool=FALSE )
			if %cl_safari% equ 1 ( set safaribool=TRUE ) else ( set safaribool=FALSE )
			if %cl_opera% equ 1 ( set operabool=TRUE ) else ( set operabool=FALSE )	
			set cl_firefox=0
			set cl_chrome=0
			set cl_edge=0
			set cl_iexplore=0
			set cl_safari=0
			set cl_opera=0
		) else (
			set nonavbool=FALSE
			set yesnavbool=TRUE
			if %cl_firefox% equ 1 ( set firefoxbool=TRUE & call :cl_firefox ) else ( set firefoxbool=FALSE )
			if %cl_chrome% equ 1 ( set chromebool=TRUE & call :cl_chrome ) else ( set chromebool=FALSE )
			if %cl_edge% equ 1 ( set edgebool=TRUE & call :cl_edge ) else ( set edgebool=FALSE )
			if %cl_iexplore% equ 1 ( set iexplorebool=TRUE & call :cl_iexplore ) else ( set iexplorebool=FALSE )
			if %cl_safari% equ 1 ( set safaribool=TRUE & call :cl_safari ) else ( set safaribool=FALSE )
			if %cl_opera% equ 1 ( set operabool=TRUE & call :cl_opera ) else ( set operabool=FALSE )
		)
	)
	if %back% equ 1 (
		if exist "%jpath%\JaspR.log" (
			del "%jpath%\JaspR.log" /f /q >nul 2>nul
		)
		if exist "%jfullpath%" (
			del /f /q "%jfullpath%" >nul 2>nul
		)
		exit
	)
	if %settings% equ 1 call :settings_function
	if %help% equ 1 call :help_function
	if %back% equ 0 (
		if %confirm_clean% equ 0 (
			if %analyse% equ 0 (
				if %settings% equ 0 (
					if %help% equ 0 (
							if exist "%jpath%\JaspR.log" del "%jpath%\JaspR.log" /f /q >nul 2>nul
							if exist "%jfullpath%" del /f /q "%jfullpath%" >nul 2>nul
						exit
					)
				)
			)
		)
	)
::PROGRESSBAR FINALE SUR LA CONSOLE
::cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
	if "%lang_fr_state%"=="TRUE" (
		echo         Cette op‚ration peut prendre un certain temps...
		echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
	) else (
		echo                This operation may take a while...
		echo           So sit back and relax while JaspR is working.
	)
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ100%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
::CALCUL DE LA TAILLE TOTALE DE DONNEES (EN MO)
	set /a ttlclnsz=ttlclnsz/1024/1024
	if not defined ttlclnsz set /a ttlclnsz=0
::INSCRIPTION DE LA TAILLE TOTALE DANS LE RAPPORT
	if not %ttlclnsz% gtr 0 (
			if not %analyse% equ 1 (
					if "%lang_fr_state%"=="TRUE" (
						echo Aucune donnée n'a été effacée ! >>"%jpath%\JaspR.log"
					) else (
						echo Nothing was removed ! >>"%jpath%\JaspR.log"
					)
			) else (
					if "%lang_fr_state%"=="TRUE" (
						echo Aucune donnée à supprimer ! >>"%jpath%\JaspR.log"
					) else (
						echo Nothing to remove ! >>"%jpath%\JaspR.log"
					)
			)
	) else (
		echo.>>"%jpath%\JaspR.log"
			if not %analyse% equ 1 (
					if "%lang_fr_state%"=="TRUE" (
						echo Environ %ttlclnsz% Mo supprimé^(s^). >>"%jpath%\JaspR.log"
					) else (
						echo Approximatively %ttlclnsz% Mo removed. >>"%jpath%\JaspR.log"
					)
			) else (
					if "%lang_fr_state%"=="TRUE" (
						echo Environ %ttlclnsz% Mo à supprimer. >>"%jpath%\JaspR.log"
					) else (
						echo Approximatively %ttlclnsz% Mo to remove. >>"%jpath%\JaspR.log"
					)
			)
	)
::CREATION DU SCRIPT DE LECTURE DU RAPPORT
echo Dim objFSO >"%tmp%\clndsz.vbs"
echo Dim objTextFile >>"%tmp%\clndsz.vbs"
echo Dim strText >>"%tmp%\clndsz.vbs"
echo on error resume next >>"%tmp%\clndsz.vbs"
echo Set objFSO = CreateObject("Scripting.FileSystemObject") >>"%tmp%\clndsz.vbs"
echo Set objTextFile = objFSO.OpenTextFile("%jpath%\JaspR.log", 1) >>"%tmp%\clndsz.vbs"
echo strText = objTextFile.ReadAll >>"%tmp%\clndsz.vbs"
echo objTextFile.Close >>"%tmp%\clndsz.vbs"
echo msgbox strText, 64+vbokonly+vbSystemModal, "JaspR Rapport" >>"%tmp%\clndsz.vbs"
::AFFICHAGE DU RAPPORT (MSGBOX)
"%tmp%\clndsz.vbs"
::SUPPRESSION DU SCRIPT ET DU RAPPORT
del /f /q "%tmp%\clndsz.vbs" >nul 2>nul
del /f /q "%jpath%\JaspR.log" >nul 2>nul
::RETOUR AU DEBUT DU PROGRAMME
goto start_cl_tool



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::FONCTIONS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
goto:eof

:settings_function
set lang_fr=0
set lang_en=0
set confirm_settings=0
set back_settings=0
	if exist "%jpath%\JaspRico.ico" (
		call :resultgui "%jlangpath%" #settingswi
	) else (
		call :resultgui "%jlangpath%" #settings
	)
	if %confirm_settings% equ 1 (
		if %lang_fr% equ 1 (
			if exist "%jpath%\lang\fra.lang" (
				echo fra;>"%jpath%\lang\pref.ini"
				set lang_fr_state=TRUE
				set lang_en_state=FALSE
				set jlangpath="%jpath%\lang\fra.lang"
				goto start_cl_tool
			) else (
				echo msgbox "Le support multi-langages est introuvable.", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\lang_multi_error.vbs"
				"%tmp%\lang_multi_error.vbs"
				del /f /q "%tmp%\lang_multi_error.vbs" >nul 2>nul
				goto start_cl_tool
			)
		)
		if %lang_en% equ 1 (
			if exist "%jpath%\lang\eng.lang" (
				echo eng;>"%jpath%\lang\pref.ini"
				set lang_fr_state=FALSE
				set lang_en_state=TRUE
				set jlangpath="%jpath%\lang\eng.lang"
				goto start_cl_tool
			) else (
				echo msgbox "The multi-language support was not found.", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\lang_multi_error.vbs"
				"%tmp%\lang_multi_error.vbs"
				del /f /q "%tmp%\lang_multi_error.vbs" >nul 2>nul
				goto start_cl_tool
			)
		)
	) else (
		goto start_cl_tool
	)

goto:eof

:help_function
	if exist "%jpath%\help\help.html" (
		"%jpath%\help\help.html"
	) else (
			if "%lang_pref%"=="fra" (
				echo msgbox "Aide JaspR" ^& vbcrlf ^& vbcrlf ^& "Dans le menu principal, sélectionnez les éléments que vous voulez que JaspR nettoie ou analyse." ^& vbcrlf ^& vbcrlf ^& "Ensuite, si vous voulez simplement connaître la taille que pourriez économiser en supprimant ces éléments, cliquez sur Analyser." ^& vbcrlf ^& vbcrlf ^& "Sinon, si vous voulez les nettoyer, cliquez sur Nettoyer.", 64+vbokonly+vbSystemModal, "JaspR Help" >"%tmp%\jaspr_help.vbs"
			) else ( 
				echo msgbox "JaspR Help" ^& vbcrlf ^& vbcrlf ^& "In the main menu, check the items you want JaspR to clean or to analyse." ^& vbcrlf ^& vbcrlf ^& "Then, if you just want to know the space you could save by cleaning these items, click on Analyze." ^& vbcrlf ^& vbcrlf ^& "Else, if you want to clean them, click on Clean.", 64+vbokonly+vbSystemModal, "JaspR Help" >"%tmp%\jaspr_help.vbs"
			)
		"%tmp%\jaspr_help.vbs"
		del /f /q "%tmp%\jaspr_help.vbs" >nul 2>nul
	)
goto start_cl_tool
goto:eof

::FONCTION AGRAFV2 : RECUPERATION DES VARIABLES BOOLEENNES (TRUE OU FALSE)
goto:eof
:resultgui
FOR /F "tokens=1,* delims=:" %%A IN ('%agraf_path% "%~1" %2') DO set %%A=%%B
goto:eof

:clean_algo

for /f "tokens=*" %%i in ('dir /s /b /a-d "%~1" 2^>nul') do if exist "%%i" (
	echo "%%i" |find /i "%jname:~0,5%" >nul || (
			if not "%%i"=="%tmp_source_code%" (
					if %analyse% equ 1 (
						2>nul (
						>>"%%i" (call )
						) && (
								if %%~zi neq 0 (
									set /a ttlclnsz=ttlclnsz+%%~zi
								)
						)
					) else (
							if %%~zi neq 0 (
								set /a ttlclnsz=ttlclnsz+%%~zi
							)
						del "%%i" /f /q /ah /ar /ai /aa >nul 2>nul
							if exist "%%i" (
									if defined ttlclnsz (
											if %%~zi neq 0 (
												set /a ttlclnsz=ttlclnsz-%%~zi
											)
									)
							)
					)
			)
		)
	)
	
goto:eof

:clean_algo_alt_j
for /f "tokens=*" %%i in ('dir /b /ad "%~1" 2^>nul') do for /f "tokens=*" %%j in ('dir /b /s /a-d "%~2" 2^>nul') do if exist "%%j" (
	echo "%%j" |find /i "%jname:~0,5%" >nul || (
			if not "%%j"=="%tmp_source_code%" (
					if %analyse% equ 1 (
						2>nul (
						>>"%%j" (call )
						) && (
								if %%~zj neq 0 (
									set /a ttlclnsz=ttlclnsz+%%~zj
								)
						)
					) else (
							if %%~zj neq 0 (
								set /a ttlclnsz=ttlclnsz+%%~zj
							)
						del "%%j" /f /q /ah /ar /ai /aa >nul 2>nul
							if exist "%%j" (
									if defined ttlclnsz (
											if %%~zj neq 0 (
												set /a ttlclnsz=ttlclnsz-%%~zj
											)
									)
							)
					)
			)
		)
	)

goto:eof

:clean_algo_alt_single_file
for %%i in ("%~1") do if exist "%%i" (
	echo "%%i" |find /i "%jname:~0,5%" >nul || (
			if not "%%i"=="%tmp_source_code%" (
					if %analyse% equ 1 (
						2>nul (
						>>"%%i" (call )
						) && (
								if %%~zi neq 0 (
									set /a ttlclnsz=ttlclnsz+%%~zi
								)
						)
					) else (
							if %%~zi neq 0 (
								set /a ttlclnsz=ttlclnsz+%%~zi
							)
						del "%%i" /f /q /ah /ar /ai /aa >nul 2>nul
							if exist "%%i" (
									if defined ttlclnsz (
											if %%~zi neq 0 (
												set /a ttlclnsz=ttlclnsz-%%~zi
											)
									)
							)
					)
			)
		)
	)

goto:eof

::FONCTION DE NETTOYAGE DES FICHIERS TEMPORAIRES
:tempclean
call :clean_algo "%windir%\temp"
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%windir%\temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%windir%\System32\config\systemprofile\Local Settings\Temp"
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%windir%\System32\config\systemprofile\Local Settings\Temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%localappdata%\temp"
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%localappdata%\temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set cl_temp_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
set /a cl_temp_size=%ttlclnsz%/1024/1024
	if %cl_temp_size% gtr 0 (
			if "%lang_fr_state%"=="TRUE" (
				echo Fichiers Temporaires : %cl_temp_size% Mo >>"%jpath%\JaspR.log"
			) else (
				echo Temporary Files : %cl_temp_size% Mo >>"%jpath%\JaspR.log"
			)
	)
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |find "1" >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛ                   10%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
			echo.
		) || (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛ                16%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		)
	)
goto:eof

::FONCTION DE NETTOYAGE DES FICHIERS JOURNAL WINDOWS
:logwindowsclean
call :clean_algo "%windir%\*.log"

call :clean_algo "%allusersprofile%\Microsoft\Windows\WER\*.wer"

set cl_winlog_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
set /a cl_winlog_size=(%ttlclnsz%-%cl_temp_size%*1024*1024)/1024/1024
	if %cl_winlog_size% gtr 0 (
			if "%lang_fr_state%"=="TRUE" (
				echo Fichiers Journal : %cl_winlog_size% Mo >>"%jpath%\JaspR.log"
			) else (
				echo Windows Log Files : %cl_winlog_size% Mo >>"%jpath%\JaspR.log"
			)
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |find "1" >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛ                17%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
			echo.
		) || (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ         31%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		)
	)

goto:eof

::FONCTION DE NETTOYAGE DU CACHE DES VIGNETTES
:thumbcacheclean
call :clean_algo "%localappdata%\microsoft\windows\explorer\thumbcache*.db"

call :clean_algo "%localappdata%\Microsoft\Windows\Explorer\ThumbCacheToDelete"

for /f "tokens=*" %%i in ('dir /s /b /ad "%localappdata%\Microsoft\Windows\Explorer" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set cl_thumb_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
set /a cl_thumb_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024)/1024/1024
	if %cl_thumb_size% gtr 0 (
			if "%lang_fr_state%"=="TRUE" (
				echo Cache des Vignettes : %cl_thumb_size% Mo >>"%jpath%\JaspR.log"
			) else (
				echo Thumbnails' Cache : %cl_thumb_size% Mo >>"%jpath%\JaspR.log"
			)
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |find "1" >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛ              19%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
			echo.
		) || (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ   42%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		)
	)

goto:eof

::FONCTION DE NETTOYAGE DE LA CORBEILLE
:trashclean
call :clean_algo "%systemdrive%\$Recycle.Bin"

set cl_trash_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
set /a cl_trash_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024)/1024/1024
	if %cl_trash_size% gtr 0 (
			if "%lang_fr_state%"=="TRUE" (
				echo Corbeille : %cl_trash_size% Mo >>"%jpath%\JaspR.log"
			) else (
				echo Trash : %cl_trash_size% Mo >>"%jpath%\JaspR.log"
			)
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |find "1" >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ         29%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		) || (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ54%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		)
	)

goto:eof

::FONCTION DE NETTOYAGE DE LA LISTE DES FICHIERS RECENTS
:recentfileslistclean
call :clean_algo "%appdata%\microsoft\windows\recent"

call :clean_algo "%windir%\System32\config\systemprofile\Recent"

call :clean_algo_alt_j "%users_dir%" "%users_dir%\%%i\Recent"

if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /b /ad "%users_dir%"') do for /f "tokens=*" %%j in ('dir /b /s /ad "%users_dir%\%%i\Recent" 2^>nul') do if exist "%%j" rd /q "%%j" >nul 2>nul

set cl_recent_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
set /a cl_recent_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024)/1024/1024
	if %cl_recent_size% gtr 0 (
			if "%lang_fr_state%"=="TRUE" (
				echo Liste des Fichiers Récents : %cl_recent_size% Mo >>"%jpath%\JaspR.log"
			) else (
				echo Recent Files' List : %cl_recent_size% Mo >>"%jpath%\JaspR.log"
			)
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |find "1" >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ      37%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		) || (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ68%%ÛÛÛÛÛÛÛ                ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		)
	)

goto:eof

::FONCTION DE NETTOYAGE DES VIEILLES DONNEES DU PREFETCH
:prefetchclean
call :clean_algo "%windir%\prefetch"
for /f "tokens=*" %%i in ('dir /s /b /ad "%windir%\prefetch" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set cl_prefetch_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
set /a cl_prefetch_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024)/1024/1024
	if %cl_prefetch_size% gtr 0 (
			if "%lang_fr_state%"=="TRUE" (
				echo Vieilles Données du Prefetch : %cl_prefetch_size% Mo >>"%jpath%\JaspR.log"
			) else (
				echo Old Prefetch's Data : %cl_prefetch_size% Mo >>"%jpath%\JaspR.log"
			)
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |find "1" >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ 46%%                       ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		) || (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ82%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛ         ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		)
	)

goto:eof

::FONCTION DE DESACTIVATION DE LA MISE EN VEILLE PROLONGEE
:hiberoff
if not exist "%systemdrive%\hiberfil.sys" goto:eof
set hiberfilsize=0
echo Dim fso >"%tmp%\GFS.vbs"
echo Dim ObjOutFile >>"%tmp%\GFS.vbs"
echo Dim ObjFile >>"%tmp%\GFS.vbs"
echo Dim ObjFileTGS >>"%tmp%\GFS.vbs"
echo Set fso = CreateObject^("Scripting.FileSystemObject"^) >>"%tmp%\GFS.vbs"
echo Set ObjOutFile = fso.CreateTextFile^("%tmp%\hibersiz.tmp"^) >>"%tmp%\GFS.vbs"
echo ObjFile = "%systemdrive%\hiberfil.sys" >>"%tmp%\GFS.vbs"
echo set ObjFileTGS = fso.GetFile^(ObjFile^) >>"%tmp%\GFS.vbs"
echo ObjOutFile.WriteLine ObjFileTGS.size >>"%tmp%\GFS.vbs"
echo ObjOutFile.Close >>"%tmp%\GFS.vbs"
"%tmp%\GFS.vbs"
set /p hiberfilsize= <%tmp%\hibersiz.tmp
del /f /q "%tmp%\hibersiz.tmp" >nul 2>nul
del /f /q "%tmp%\GFS.vbs" >nul 2>nul
if %hiberfilsize% neq 0 set /a ttlclnsz += %hiberfilsize%
powercfg /h off >nul 2>nul
	if exist "%systemdrive%\hiberfil.sys" (
		if defined ttlclnsz (
			if %hiberfilsize% neq 0 (
				set /a ttlclnsz = %ttlclnsz%-%hiberfilsize%
			)
		)
	)

set /a hiberfilsizemo=%hiberfilsize%/1024/1024
	if defined hiberfilsize (
			if %hiberfilsize% gtr 0 (
					if "%lang_fr_state%"=="TRUE" (
						echo Supp. Mise en Veille Prolongée : %hiberfilsizemo% Mo >>"%jpath%\JaspR.log"
					) else (
						echo Deactivate Hibernation : %hiberfilsizemo% Mo >>"%jpath%\JaspR.log"
					)
			)
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |find "1" >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ55%%ÛÛ                     ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		) || (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
				if "%lang_fr_state%"=="TRUE" (
					echo         Cette op‚ration peut prendre un certain temps...
					echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
				) else (
					echo                This operation may take a while...
					echo           So sit back and relax while JaspR is working.
				)
			echo.
			echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ100%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ³
			echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			echo.
		)
	)

goto:eof

::FONCTION DE NETTOYAGE DE FIREFOX
:cl_firefox
tasklist |find /i "firefox.exe" >nul 2>nul & if not errorlevel 1 goto firefoxopened

:cl_firefoxkd
call :clean_algo "%localfirefoxdir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localfirefoxdir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%roamingfirefoxdir%\*.sqlite"

set cl_firefox_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
if "%cl_prefetch_size%"=="" set /a cl_prefetch_size=0
if "%hiberfilsize%"=="" set /a hiberfilsize=0
set /a cl_firefox_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024-%cl_prefetch_size%*1024*1024-%hiberfilsize%)/1024/1024
	if %cl_firefox_size% gtr 0 (
		echo Firefox : %cl_firefox_size% Mo >>"%jpath%\JaspR.log"
	)
	
cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
	if "%lang_fr_state%"=="TRUE" (
		echo         Cette op‚ration peut prendre un certain temps...
		echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
	) else (
		echo                This operation may take a while...
		echo           So sit back and relax while JaspR is working.
	)
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ64%%ÛÛÛÛÛ                  ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.

goto:eof

:firefoxopened
set backfirefox=0
set cl_close=0
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jlangpath%" #confirmkillfirefoxwi
) else (
call :resultgui "%jlangpath%" #confirmkillfirefox
)
	if %cl_close% equ 1 (
		taskkill /f /im firefox.exe >nul 2>nul
		goto cl_firefoxkd
	) else (
			if "%lang_fr_state%"=="TRUE" (
				echo Firefox : Ignoré >>"%jpath%\JaspR.log"
			) else (
				echo Firefox : Skipped >>"%jpath%\JaspR.log"
			)
		goto:eof
	)

::FONCTION DE NETTOYAGE DE GOOGLE CHROME
:cl_chrome
tasklist |find /i "chrome.exe" >nul 2>nul & if not errorlevel 1 goto chromeopened

:cl_chromekd
call :clean_algo "%localchromedir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localchromedir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set cl_chrome_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
if "%cl_prefetch_size%"=="" set /a cl_prefetch_size=0
if "%hiberfilsize%"=="" set /a hiberfilsize=0
if "%cl_firefox_size%"=="" set /a cl_firefox_size=0
set /a cl_chrome_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024-%cl_prefetch_size%*1024*1024-%hiberfilsize%-%cl_firefox_size%*1024*1024)/1024/1024
	if %cl_chrome_size% gtr 0 (
		echo Google Chrome : %cl_chrome_size% Mo >>"%jpath%\JaspR.log"
	)

cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
	if "%lang_fr_state%"=="TRUE" (
		echo         Cette op‚ration peut prendre un certain temps...
		echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
	) else (
		echo                This operation may take a while...
		echo           So sit back and relax while JaspR is working.
	)
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ72%%ÛÛÛÛÛÛÛÛÛ              ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.

goto:eof

:chromeopened
set backchrome=0
set cl_close=0
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jlangpath%" #confirmkillchromewi
) else (
call :resultgui "%jlangpath%" #confirmkillchrome
)
	if %cl_close% equ 1 (
		taskkill /f /im chrome.exe >nul 2>nul
		goto cl_chromekd
	) else (
			if "%lang_fr_state%"=="TRUE" (
				echo Google Chrome : Ignoré >>"%jpath%\JaspR.log"
			) else (
				echo Google Chrome : Skipped >>"%jpath%\JaspR.log"
			)
		goto:eof
	)

::FONCTION DE NETTOYAGE DE MICROSOFT EDGE
:cl_edge
tasklist |find /i "MicrosoftEdge.exe" || tasklist |find /i "MicrosoftEdgeCP.exe" >nul 2>nul & if not errorlevel 1 goto edgeopened

:cl_edgekd
call :clean_algo_alt_j "%localappdata%\Packages\Microsoft.MicrosoftEdge*" "%localappdata%\Packages\%%i\AC"

set cl_edge_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
if "%cl_prefetch_size%"=="" set /a cl_prefetch_size=0
if "%hiberfilsize%"=="" set /a hiberfilsize=0
if "%cl_firefox_size%"=="" set /a cl_firefox_size=0
if "%cl_chrome_size%"=="" set /a cl_chrome_size=0
set /a cl_edge_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024-%cl_prefetch_size%*1024*1024-%hiberfilsize%-%cl_firefox_size%*1024*1024-%cl_chrome_size%*1024*1024)/1024/1024
	if %cl_edge_size% gtr 0 (
		echo Microsoft Edge : %cl_edge_size% Mo >>"%jpath%\JaspR.log"
	)

cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
	if "%lang_fr_state%"=="TRUE" (
		echo         Cette op‚ration peut prendre un certain temps...
		echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
	) else (
		echo                This operation may take a while...
		echo           So sit back and relax while JaspR is working.
	)
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ79%%ÛÛÛÛÛÛÛÛÛÛÛÛ           ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:edgeopened
set backedge=0
set cl_close=0
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jlangpath%" #confirmkilledgewi
) else (
call :resultgui "%jlangpath%" #confirmkilledge
)
	if %cl_close% equ 1 (
		taskkill /f /im MicrosoftEdge.exe >nul 2>nul
		taskkill /f /im MicrosoftEdgeCP.exe >nul 2>nul
		goto cl_edgekd
	) else (
			if "%lang_fr_state%"=="TRUE" (
				echo Microsoft Edge : Ignoré >>"%jpath%\JaspR.log"
			) else (
				echo Microsoft Edge : Skipped >>"%jpath%\JaspR.log"
			)
		goto:eof
	)

::FONCTION DE NETTOYAGE D'INTERNET EXPLORER
:cl_iexplore
tasklist |find /i "iexplore.exe" >nul 2>nul & if not errorlevel 1 goto iexploreopened

:cl_iexplorekd
call :clean_algo "%localIEdir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localIEdir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%localhistoryIEdir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localhistoryIEdir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%localtempIEdir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localtempIEdir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%roamingcookiesIEdir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%roamingcookiesIEdir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%localappdata%\Microsoft\Windows\Temporary Internet Files"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localappdata%\Microsoft\Windows\Temporary Internet Files" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%localappdata%\microsoft\windows\inetcache"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localappdata%\microsoft\windows\inetcache" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

if not %analyse% equ 1 reg delete "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\TypedURLs" /va /f >nul 2>nul

set cl_iexplore_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
if "%cl_prefetch_size%"=="" set /a cl_prefetch_size=0
if "%hiberfilsize%"=="" set /a hiberfilsize=0
if "%cl_firefox_size%"=="" set /a cl_firefox_size=0
if "%cl_chrome_size%"=="" set /a cl_chrome_size=0
if "%cl_edge_size%"=="" set /a cl_edge_size=0
set /a cl_iexplore_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024-%cl_prefetch_size%*1024*1024-%hiberfilsize%-%cl_firefox_size%*1024*1024-%cl_chrome_size%*1024*1024-%cl_edge_size%*1024*1024)/1024/1024
	if %cl_iexplore_size% gtr 0 (
		echo Internet Explorer : %cl_iexplore_size% Mo >>"%jpath%\JaspR.log"
	)
	
cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
	if "%lang_fr_state%"=="TRUE" (
		echo         Cette op‚ration peut prendre un certain temps...
		echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
	) else (
		echo                This operation may take a while...
		echo           So sit back and relax while JaspR is working.
	)
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ87%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ      ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:iexploreopened
set backiexplore=0
set cl_close=0
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jlangpath%" #confirmkilliexplorewi
) else (
call :resultgui "%jlangpath%" #confirmkilliexplore
)
	if %cl_close% equ 1 (
		taskkill /f /im iexplore.exe >nul 2>nul
		goto cl_iexplorekd
	) else (
			if "%lang_fr_state%"=="TRUE" (
				echo Internet Explorer : Ignoré >>"%jpath%\JaspR.log"
			) else (
				echo Internet Explorer : Skipped >>"%jpath%\JaspR.log"
			)
		goto:eof
	)

::FONCTION DE NETTOYAGE DE SAFARI
:cl_safari
tasklist |find /i "safari.exe" >nul 2>nul & if not errorlevel 1 goto safariopened

:cl_safarikd
call :clean_algo "%localhistorysafaridir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localhistorysafaridir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo_alt_single_file "%localsafaridir%\Cache.db"

call :clean_algo_alt_single_file "%localsafaridir%\WebpageIcons.db"

call :clean_algo "%roamingsafaridir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%roamingsafaridir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul
	
set cl_safari_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
if "%cl_prefetch_size%"=="" set /a cl_prefetch_size=0
if "%hiberfilsize%"=="" set /a hiberfilsize=0
if "%cl_firefox_size%"=="" set /a cl_firefox_size=0
if "%cl_chrome_size%"=="" set /a cl_chrome_size=0
if "%cl_edge_size%"=="" set /a cl_edge_size=0
if "%cl_iexplore_size%"=="" set /a cl_iexplore_size=0
set /a cl_safari_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024-%cl_prefetch_size%*1024*1024-%hiberfilsize%-%cl_firefox_size%*1024*1024-%cl_chrome_size%*1024*1024-%cl_edge_size%*1024*1024-%cl_iexplore_size%*1024*1024)/1024/1024
	if %cl_safari_size% gtr 0 (
		echo Safari : %cl_safari_size% Mo >>"%jpath%\JaspR.log"
	)
	
cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
	if "%lang_fr_state%"=="TRUE" (
		echo         Cette op‚ration peut prendre un certain temps...
		echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
	) else (
		echo                This operation may take a while...
		echo           So sit back and relax while JaspR is working.
	)
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ92%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ    ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:safariopened
set backsafari=0
set cl_close=0
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jlangpath%" #confirmkillsafariwi
) else (
call :resultgui "%jlangpath%" #confirmkillsafari
)
	if %cl_close% equ 1 (
		taskkill /f /im safari.exe >nul 2>nul
		goto cl_safarikd
	) else (
			if "%lang_fr_state%"=="TRUE" (
				echo Safari : Ignoré >>"%jpath%\JaspR.log"
			) else (
				echo Safari : Skipped >>"%jpath%\JaspR.log"
			)
		goto:eof
	)

::FONCTION DE NETTOYAGE D'OPERA
:cl_opera
tasklist |find /i "opera.exe" >nul 2>nul & if not errorlevel 1 goto operaopened

:cl_operakd
call :clean_algo "%localoperadir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localoperadir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%roamingoperadir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%roamingoperadir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set cl_opera_size=0
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
if "%cl_prefetch_size%"=="" set /a cl_prefetch_size=0
if "%hiberfilsize%"=="" set /a hiberfilsize=0
if "%cl_firefox_size%"=="" set /a cl_firefox_size=0
if "%cl_chrome_size%"=="" set /a cl_chrome_size=0
if "%cl_edge_size%"=="" set /a cl_edge_size=0
if "%cl_iexplore_size%"=="" set /a cl_iexplore_size=0
if "%cl_safari_size%"=="" set /a cl_safari_size=0
set /a cl_opera_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024-%cl_prefetch_size%*1024*1024-%hiberfilsize%-%cl_firefox_size%*1024*1024-%cl_chrome_size%*1024*1024-%cl_edge_size%*1024*1024-%cl_iexplore_size%*1024*1024-%cl_safari_size%*1024*1024)/1024/1024
	if %cl_opera_size% gtr 0 (
		echo Opera : %cl_opera_size% Mo >>"%jpath%\JaspR.log"
	)
	
cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
	if "%lang_fr_state%"=="TRUE" (
		echo         Cette op‚ration peut prendre un certain temps...
		echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
	) else (
		echo                This operation may take a while...
		echo           So sit back and relax while JaspR is working.
	)
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ100%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:operaopened
set backopera=0
set cl_close=0
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jlangpath%" #confirmkilloperawi
) else (
call :resultgui "%jlangpath%" #confirmkillopera
)
	if %cl_close% equ 1 (
		taskkill /f /im opera.exe >nul 2>nul
		goto cl_operakd
	) else (
			if "%lang_fr_state%"=="TRUE" (
				echo Opera : Ignoré >>"%jpath%\JaspR.log"
			) else (
				echo Opera : Skipped >>"%jpath%\JaspR.log"
			)
		goto:eof
	)


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::FAIL-SAFE GRAPHICAL USER INTERFACE::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	
::#cl_mainwi
::Window "JaspR" 450 440
::icon "%jpath%\JaspRico.ico"
::Text "Select elements you want to clean :" 10 40 350 15
::checkbox "tempfiles" "Temporary Files" %tempbool% 20 90 180 25
::checkbox "emptytrash" "Empty Trash" %trashbool% 20 120 180 25
::checkbox "recentfiles" "Recent Files' List" %recentbool% 20 150 180 25
::checkbox "logwindows" "Windows' Log Files" %winlogbool% 200 90 180 25
::checkbox "thumbcache" "Thumbnails' Cache" %thumbbool% 200 120 180 25
::checkbox "prefetch" "Old Prefetch's Data" %prefetchbool% 200 150 180 25
::checkbox "hiberstate" "Deactivate Hibernation" %hiberbool% 20 180 250 25
::Text "Browsers :" 20 240 70 15
::radio "yes_clean_nav" "Yes" %yesnavbool% navch 90 235 50 25
::radio "no_clean_nav" "No" %nonavbool% navch 145 235 50 25
::checkbox "cl_firefox" "Mozilla Firefox" %firefoxbool% 20 280 100 25
::checkbox "cl_chrome" "Google Chrome" %chromebool% 150 280 110 25
::checkbox "cl_edge" "Microsoft Edge" %edgebool% 280 280 100 25
::checkbox "cl_iexplore" "Internet Explorer" %iexplorebool% 20 315 115 25
::checkbox "cl_safari" "Safari" %safaribool% 150 315 100 25
::checkbox "cl_opera" "Opera" %operabool% 280 315 100 25
::Button "back" "Exit" 75 360 75 25 Popup
::Button "analyse" "Analyze" 178 360 75 25 Popup
::Button "confirm_clean" "Clean" 280 360 75 25 Popup
::Button "settings" "Settings" 0 0 75 20 Popup
::Button "help" "Help" 75 0 75 20 Popup
::Text "Fail-Safe GUI" 360 0 100 15
::#EndGui

::#confirmkillfirefoxwi
::Window "Closing Firefox" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backfirefox" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Firefox ?" 90 100 250 15
::Text "Firefox is currently running." 115 50 250 15
::Text "You must close Firefox before cleaning." 85 70 300 15
::Text "Closing Firefox" 140 10 150 15
::#EndGui

::#confirmkillchromewi
::Window "Closing Google Chrome" 380 210
::icon "%jpath%\JaspRico.ico"
::Button "backchrome" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Google Chrome ?" 67 100 300 15
::Text "Google Chrome is currently running." 90 50 300 15
::Text "You must close Google Chrome before cleaning." 60 70 320 15
::Text "Closing Google Chrome" 120 10 175 15
::#EndGui

::#confirmkilledgewi
::Window "Closing Microsoft Edge" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backedge" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Microsoft Edge ?" 75 100 250 15
::Text "Microsoft Edge is currently running." 100 50 300 15
::Text "You must close Microsoft Edge before cleaning." 70 70 300 15
::Text "Closing Microsoft Edge" 125 10 200 15
::#EndGui

::#confirmkilliexplorewi
::Window "Closing Internet Explorer" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backiexplore" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Internet Explorer ?" 67 100 300 15
::Text "Internet Explorer is currently running." 90 50 300 15
::Text "You must close Internet Explorer before cleaning." 63 70 300 15
::Text "Closing Internet Explorer" 120 10 175 15
::#EndGui

::#confirmkillsafariwi
::Window "Closing Safari" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backsafari" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Safari ?" 93 100 250 15
::Text "Safari is currently running." 115 50 250 15
::Text "You must close Safari before cleaning." 85 70 300 15
::Text "Closing Safari" 145 10 150 15
::#EndGui

::#confirmkilloperawi
::Window "Closing Opera" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backopera" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Opera ?" 93 100 250 15
::Text "Opera is currently running." 115 50 250 15
::Text "You must close Opera before cleaning." 85 70 300 15
::Text "Closing Opera" 145 10 150 15
::#EndGui

::#settingswi
::Window "Settings" 340 180
::icon "%jpath%\JaspRico.ico"
::Button "back_settings" "Cancel" 70 100 75 20
::Button "confirm_settings" "Ok" 170 100 75 20
::radio "lang_en" "English" %lang_en_state% lang_select 125 50 100 20
::radio "lang_fr" "FranÃ§ais" %lang_fr_state% lang_select 20 50 100 20
::AddStyle "lang_fr" 9
::Text "Choose the language :" 20 15 150 15
::#EndGui


::#cl_main
::Window "JaspR" 450 440
::Text "Select elements you want to clean :" 10 40 350 15
::checkbox "tempfiles" "Temporary Files" %tempbool% 20 90 180 25
::checkbox "emptytrash" "Empty Trash" %trashbool% 20 120 180 25
::checkbox "recentfiles" "Recent Files' List" %recentbool% 20 150 180 25
::checkbox "logwindows" "Windows' Log Files" %winlogbool% 200 90 180 25
::checkbox "thumbcache" "Thumbnails' Cache" %thumbbool% 200 120 180 25
::checkbox "prefetch" "Old Prefetch's Data" %prefetchbool% 200 150 180 25
::checkbox "hiberstate" "Deactivate Hibernation" %hiberbool% 20 180 250 25
::Text "Browsers :" 20 240 70 15
::radio "yes_clean_nav" "Yes" %yesnavbool% navch 90 235 50 25
::radio "no_clean_nav" "No" %nonavbool% navch 145 235 50 25
::checkbox "cl_firefox" "Mozilla Firefox" %firefoxbool% 20 280 100 25
::checkbox "cl_chrome" "Google Chrome" %chromebool% 150 280 110 25
::checkbox "cl_edge" "Microsoft Edge" %edgebool% 280 280 100 25
::checkbox "cl_iexplore" "Internet Explorer" %iexplorebool% 20 315 115 25
::checkbox "cl_safari" "Safari" %safaribool% 150 315 100 25
::checkbox "cl_opera" "Opera" %operabool% 280 315 100 25
::Button "back" "Exit" 75 360 75 25 Popup
::Button "analyse" "Analyze" 178 360 75 25 Popup
::Button "confirm_clean" "Clean" 280 360 75 25 Popup
::Button "settings" "Settings" 0 0 75 17 Popup
::Button "help" "Help" 75 0 75 17 Popup
::Text "Fail-Safe GUI" 360 0 100 15
::#EndGui

::#confirmkillfirefox
::Window "Closing Firefox" 392 210
::Button "backfirefox" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Firefox ?" 90 100 250 15
::Text "Firefox is currently running." 115 50 250 15
::Text "You must close Firefox before cleaning." 85 70 300 15
::Text "Closing Firefox" 140 10 150 15
::#EndGui

::#confirmkillchrome
::Window "Closing Google Chrome" 380 210
::Button "backchrome" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Google Chrome ?" 67 100 300 15
::Text "Google Chrome is currently running." 90 50 300 15
::Text "You must close Google Chrome before cleaning." 60 70 320 15
::Text "Closing Google Chrome" 120 10 175 15
::#EndGui

::#confirmkilledge
::Window "Closing Microsoft Edge" 392 210
::Button "backedge" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Microsoft Edge ?" 75 100 250 15
::Text "Microsoft Edge is currently running." 100 50 300 15
::Text "You must close Microsoft Edge before cleaning." 70 70 300 15
::Text "Closing Microsoft Edge" 125 10 200 15
::#EndGui

::#confirmkilliexplore
::Window "Closing Internet Explorer" 392 210
::Button "backiexplore" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Internet Explorer ?" 67 100 300 15
::Text "Internet Explorer is currently running." 90 50 300 15
::Text "You must close Internet Explorer before cleaning." 63 70 300 15
::Text "Closing Internet Explorer" 120 10 175 15
::#EndGui

::#confirmkillsafari
::Window "Closing Safari" 392 210
::Button "backsafari" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Safari ?" 93 100 250 15
::Text "Safari is currently running." 115 50 250 15
::Text "You must close Safari before cleaning." 85 70 300 15
::Text "Closing Safari" 145 10 150 15
::#EndGui

::#confirmkillopera
::Window "Closing Opera" 392 210
::Button "backopera" "No" 105 130 75 25
::Button "cl_close" "Yes" 195 130 75 25
::Text "Do you want JaspR to close Opera ?" 93 100 250 15
::Text "Opera is currently running." 115 50 250 15
::Text "You must close Opera before cleaning." 85 70 300 15
::Text "Closing Opera" 145 10 150 15
::#EndGui

::#settings
::Window "Settings" 340 180
::Button "confirm_settings" "Ok" 170 100 75 25 Popup
::Button "back_settings" "Cancel" 70 100 75 25 Popup
::radio "lang_en" "English" %lang_en_state% lang_select 125 50 100 20
::radio "lang_fr" "FranÃ§ais" %lang_fr_state% lang_select 20 50 100 20
::Text "Choose the language :" 20 15 150 15
::#EndGui


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::COMMANDES DU REGISTRE : A MANIPULER AVEC PRECAUTION::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v AlwaysUnloadDll /t REG_DWORD /d 1 /f >nul 2>nul
::reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v SeparateProcess /t REG_DWORD /d 1 /f >nul 2>nul
::reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >nul 2>nul
::reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul 2>nul
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 50 /f >nul 2>nul
::reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d 50 /f >nul 2>nul
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v LowLevelHooksTimeout /t REG_SZ /d 1000 /f >nul 2>nul
::reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoInternetOpenWith /t REG_DWORD /d 1 /f >nul 2>nul
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPer1_0Server /t REG_DWORD /d 12 /f >nul 2>nul
::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPerServer /t REG_DWORD /d 12 /f >nul 2>nul
::reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Filesystem /v NtfsDisable8dot3NameCreation /t REG_DWORD /d 1 /f >nul 2>nul
::reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 1000 /f >nul 2>nul
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f >nul 2>nul
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 1000 /f >nul 2>nul
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f >nul 2>nul
::reg add "HKEY_USERS\.DEFAULT\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 1000 /f >nul 2>nul
::reg add "HKEY_USERS\.DEFAULT\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f >nul 2>nul
