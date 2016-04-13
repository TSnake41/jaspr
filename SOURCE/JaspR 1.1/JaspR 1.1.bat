                                                  ::::::::::::::::::::::::::::::::::::::::::::::::: 
                                                   :::::::::::::::::::::JaspR:::::::::::::::::::::
                                                    ::  Just Another Software to Pull Rubbish  ::
                                                     :::::::::::::::::::::::::::::::::::::::::::
                                                     ::  Programme créé par Raphaël BERTEAUD  ::
                                                     ::   Membre de batch.xoo.it (</Troud>)   ::
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
		echo msgbox "Vous devez exécuter JaspR en tant qu'administrateur !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\adminRor.vbs"
		"%tmp%\adminRor.vbs"
		del /f /q "%tmp%\adminRor.vbs" >nul 2>nul
		exit /B
	)

::PARAMETRES DE LA CONSOLE
title JaspR
mode con cols=66 lines=13
echo Initialisation de JaspR, veuillez patienter...

::CREATION DU DOSSIER LOCAL JASPR
set jpath=%localappdata%\JaspR
	if not exist "%jpath%" md "%jpath%"

::COPIE DE AGRAFV2 DANS SYSTEM32 S'IL N'EXISTE PAS
	if not exist "%windir%\system32\AgrafV2.exe" (
		if exist "%~dp0\AgrafV2.exe" (
			copy "%~dp0\AgrafV2.exe" "%windir%\system32\" /y >nul 2>nul
				if not errorlevel 0 (
					echo msgbox "AgrafV2 est introuvable, JaspR a besoin d'AgrafV2.", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\agrafRor.vbs"
					"%tmp%\agrafRor.vbs"
					del /f /q "%tmp%\agrafRor.vbs" >nul 2>nul
					exit /B
				)
			
		)
	)

	if not exist "%jpath%\JaspRico.ico" (
		if exist "%~dp0\JaspRico.ico" (
			copy "%~dp0\JaspRico.ico" "%jpath%" /y >nul 2>nul
		)
	)

::VARIABLE DU DOSSIER DES UTILISATEURS
for /f "tokens=2-3 delims=\" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^| Find /i "Common AppData"') do set CAD=%systemdrive%\%%a
	if not "%CAD%"=="%systemdrive%\Documents and Settings" set CAD=%systemdrive%\Users
	
::DEFINITION DES CONSTANTES
set jext=%~x0
set jname=%~n0
set jfullpath=%~f0
	if "%jext%"==".exe" (
		if exist "%tmp%\%jname%.bat" (
			set jfullpath="%tmp%\%jname%.bat"
		) else (
			echo msgbox "Impossible de trouver le code source !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\tmpsrcRor.vbs"
			"%tmp%\tmpsrcRor.vbs"
			del /f /q "%tmp%\tmpsrcRor.vbs" >nul 2>nul
			exit /B
		)
	)
copy /y "%jfullpath%" "%jpath%" >nul 2>nul
set jfullpath=%localappdata%\JaspR\%jname%.bat

set localchromedir=%localappdata%\Google\Chrome\User Data
set localfirefoxdir=%localappdata%\Mozilla\Firefox\Profiles
set roamingfirefoxdir=%appdata%\Mozilla\Firefox\Profiles
set localoperadir=%localappdata%\Opera\Opera
set roamingoperadir=%appdata%\Opera\Opera
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
set firefoxbool=FALSE
set chromebool=FALSE
set edgebool=FALSE
set iexplorebool=FALSE
set safaribool=FALSE
set operabool=FALSE


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
set "tempfiles"==""
set /a cl_temp_size=0
set "emptytrash"==""
set /a cl_trash_size=0
set "recentfiles"==""
set /a cl_recent_size=0
set "logwindows"==""
set /a cl_winlog_size=0
set "thumbcache"==""
set /a cl_thumb_size=0
set "prefetch"==""
set /a cl_prefetch_size=0
set "hiberstate"==""
set /a hiberfilsize=0
set "yes_clean_nav"==""
set "no_clean_nav"==""
set "cl_firefox"==""
set /a cl_firefox_size=0
set "cl_chrome"==""
set /a cl_chrome_size=0
set "cl_edge"==""
set /a cl_edge_size=0
set "cl_iexplore"==""
set /a cl_iexplore_size=0
set "cl_safari"==""
set /a cl_safari_size=0
set "cl_opera"==""
set /a cl_opera_size=0
set "back"==""
set "analyse"==""
set "confirm_clean"==""

::APPEL DE LA GUI MENU
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jfullpath%" #cl_mainwi
) else (
call :resultgui "%jfullpath%" #cl_main
)

::PROGRESSBAR INITIALE SUR LA CONSOLE
cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³                        0%%                        ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
echo.
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
			set "cl_firefox"==""
			set "cl_chrome"==""
			set "cl_edge"==""
			set "cl_iexplore"==""
			set "cl_safari"==""
			set "cl_opera"==""
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
			set "cl_firefox"==""
			set "cl_chrome"==""
			set "cl_edge"==""
			set "cl_iexplore"==""
			set "cl_safari"==""
			set "cl_opera"==""
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
		if exist "%jpath%\JaspR.log" del "%jpath%\JaspR.log" /f /q >nul 2>nul
		if exist "%jfullpath%" del /f /q "%jfullpath%" >nul 2>nul
		exit /B
	)
	if %back% equ 0 (
		if %confirm_clean% equ 0 (
			if %analyse% equ 0 (
				if exist "%jpath%\JaspR.log" del "%jpath%\JaspR.log" /f /q >nul 2>nul
				if exist "%jfullpath%" del /f /q "%jfullpath%" >nul 2>nul
				exit /B
			)
		)
	)
::PROGRESSBAR FINALE SUR LA CONSOLE
cls
echo.
echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo                      º        JaspR        º
echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo Aucune donnée n'a été effacée ! >>"%jpath%\JaspR.log"
		) else (
			echo Aucune donnée à supprimer ! >>"%jpath%\JaspR.log"
		)
	) else (
		echo.>>"%jpath%\JaspR.log"
			if not %analyse% equ 1 (
				echo Environ %ttlclnsz% Mo supprimé^(s^). >>"%jpath%\JaspR.log"
			) else (
				echo Environ %ttlclnsz% Mo à supprimer. >>"%jpath%\JaspR.log"
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

::FONCTION AGRAFV2 : RECUPERATION DES VARIABLES BOOLEENNES (TRUE OU FALSE)
goto:eof
:resultgui
FOR /F "tokens=1,* delims=:" %%A IN ('AGRAFV2 "%~1" %2') DO set %%A=%%B
goto:eof

:clean_algo

for /f "tokens=*" %%i in ('dir /s /b /a-d "%~1" 2^>nul') do if exist "%%i" (
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

goto:eof

:clean_algo_alt_j
for /f "tokens=*" %%i in ('dir /b /ad "%~1" 2^>nul') do for /f "tokens=*" %%j in ('dir /b /s /a-d "%~2" 2^>nul') do if exist "%%j" (
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

goto:eof

:clean_algo_alt_single_file
for %%i in ("%~1") do if exist "%%i" (
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

goto:eof

::FONCTION DE NETTOYAGE DES FICHIERS TEMPORAIRES
:tempclean
call :clean_algo "%windir%\temp"
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%windir%\temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%windir%\System32\config\systemprofile\Local Settings\Temp"
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%windir%\System32\config\systemprofile\Local Settings\Temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%localappdata%\temp"
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%localappdata%\temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set "cl_temp_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
set /a cl_temp_size=%ttlclnsz%/1024/1024
	if %cl_temp_size% gtr 0 (
		echo Fichiers Temporaires : %cl_temp_size% Mo >>"%jpath%\JaspR.log"
	)
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |findstr 1 >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
	
set "cl_winlog_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
set /a cl_winlog_size=(%ttlclnsz%-%cl_temp_size%*1024*1024)/1024/1024
	if %cl_winlog_size% gtr 0 (
		echo Fichiers Journal : %cl_winlog_size% Mo >>"%jpath%\JaspR.log"
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |findstr 1 >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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

set "cl_thumb_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
set /a cl_thumb_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024)/1024/1024
	if %cl_thumb_size% gtr 0 (
		echo Cache des Vignettes : %cl_thumb_size% Mo >>"%jpath%\JaspR.log"
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |findstr 1 >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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

set "cl_trash_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
set /a cl_trash_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024)/1024/1024
	if %cl_trash_size% gtr 0 (
		echo Corbeille : %cl_trash_size% Mo >>"%jpath%\JaspR.log"
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |findstr 1 >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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

call :clean_algo_alt_j "%CAD%" "%CAD%\%%i\Recent"

if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /b /ad "%CAD%"') do for /f "tokens=*" %%j in ('dir /b /s /ad "%CAD%\%%i\Recent" 2^>nul') do if exist "%%j" rd /q "%%j" >nul 2>nul

set "cl_recent_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
set /a cl_recent_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024)/1024/1024
	if %cl_recent_size% gtr 0 (
		echo Liste des Fichiers Récents : %cl_recent_size% Mo >>"%jpath%\JaspR.log"
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |findstr 1 >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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

set "cl_prefetch_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
set /a cl_prefetch_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024)/1024/1024
	if %cl_prefetch_size% gtr 0 (
		echo Vieilles Données du Prefetch : %cl_prefetch_size% Mo >>"%jpath%\JaspR.log"
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |findstr 1 >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
set "hiberfilsize"==""
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
		if %hiberfilsize% gtr 0 echo Supp. Mise en Veille Prolongée : %hiberfilsizemo% Mo >>"%jpath%\JaspR.log"
	)
	
	if %yes_clean_nav% equ 1 (
		echo %cl_firefox%%cl_chrome%%cl_edge%%cl_iexplore%%cl_safari%%cl_opera% |findstr 1 >nul 2>nul && (
			cls
			echo.
			echo                      ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
			echo                      º        JaspR        º
			echo                      ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
			echo.
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
			echo         Cette op‚ration peut prendre un certain temps...
			echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
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
tasklist |find "firefox.exe" >nul 2>nul & if not errorlevel 1 goto firefoxopened

:cl_firefoxkd
call :clean_algo "%localfirefoxdir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localfirefoxdir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%roamingfirefoxdir%\*.sqlite"

set "cl_firefox_size"==""
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
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ64%%ÛÛÛÛÛ                  ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.

goto:eof

:firefoxopened
set "backfirefox"==""
set "cl_close"==""
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jfullpath%" #confirmkillfirefoxwi
) else (
call :resultgui "%jfullpath%" #confirmkillfirefox
)
	if %cl_close% equ 1 taskkill /f /im firefox.exe >nul 2>nul
goto cl_firefoxkd

::FONCTION DE NETTOYAGE DE GOOGLE CHROME
:cl_chrome
tasklist |find "chrome.exe" >nul 2>nul & if not errorlevel 1 goto chromeopened

:cl_chromekd
call :clean_algo "%localchromedir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localchromedir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set "cl_chrome_size"==""
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
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ72%%ÛÛÛÛÛÛÛÛÛ              ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.

goto:eof

:chromeopened
set "backchrome"==""
set "cl_close"==""
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jfullpath%" #confirmkillchromewi
) else (
call :resultgui "%jfullpath%" #confirmkillchrome
)
	if %cl_close% equ 1 taskkill /f /im chrome.exe >nul 2>nul
goto cl_chromekd

::FONCTION DE NETTOYAGE DE MICROSOFT EDGE
:cl_edge
tasklist |find "MicrosoftEdge.exe" || tasklist |find "MicrosoftEdgeCP.exe" >nul 2>nul & if not errorlevel 1 goto edgeopened

:cl_edgekd
call :clean_algo_alt_j "%localappdata%\Packages\Microsoft.MicrosoftEdge*" "%localappdata%\Packages\%%i\AC"

set "cl_edge_size"==""
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
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ79%%ÛÛÛÛÛÛÛÛÛÛÛÛ           ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:edgeopened
set "backedge"==""
set "cl_close"==""
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jfullpath%" #confirmkilledgewi
) else (
call :resultgui "%jfullpath%" #confirmkilledge
)
	if %cl_close% equ 1 taskkill /f /im MicrosoftEdge.exe >nul 2>nul & taskkill /f /im MicrosoftEdgeCP.exe >nul 2>nul
goto cl_edgekd

::FONCTION DE NETTOYAGE D'INTERNET EXPLORER
:cl_iexplore
tasklist |find "iexplore.exe" >nul 2>nul & if not errorlevel 1 goto iexploreopened

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

set "cl_iexplore_size"==""
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
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ87%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ      ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:iexploreopened
set "backiexplore"==""
set "cl_close"==""
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jfullpath%" #confirmkilliexplorewi
) else (
call :resultgui "%jfullpath%" #confirmkilliexplore
)
	if %cl_close% equ 1 taskkill /f /im iexplore.exe >nul 2>nul
goto cl_iexplorekd

::FONCTION DE NETTOYAGE DE SAFARI
:cl_safari
tasklist |find "safari.exe" >nul 2>nul & if not errorlevel 1 goto safariopened

:cl_safarikd
call :clean_algo "%localhistorysafaridir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localhistorysafaridir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo_alt_single_file "%localsafaridir%\Cache.db"

call :clean_algo_alt_single_file "%localsafaridir%\WebpageIcons.db"

call :clean_algo "%roamingsafaridir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%roamingsafaridir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul
	
set "cl_safari_size"==""
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
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ92%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ    ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:safariopened
set "backsafari"==""
set "cl_close"==""
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jfullpath%" #confirmkillsafariwi
) else (
call :resultgui "%jfullpath%" #confirmkillsafari
)
	if %cl_close% equ 1 taskkill /f /im safari.exe >nul 2>nul
goto cl_safarikd

::FONCTION DE NETTOYAGE D'OPERA
:cl_opera
tasklist |find "opera.exe" >nul 2>nul & if not errorlevel 1 goto operaopened

:cl_operakd
call :clean_algo "%localoperadir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%localoperadir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

call :clean_algo "%roamingoperadir%"
for /f "tokens=*" %%i in ('dir /s /b /ad "%roamingoperadir%" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set "cl_opera_size"==""
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
echo         Cette op‚ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d‚tendez-vous.
echo.
echo       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       ³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ100%%ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ³
echo       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
	
goto:eof

:operaopened
set "backopera"==""
set "cl_close"==""
if exist "%jpath%\JaspRico.ico" (
call :resultgui "%jfullpath%" #confirmkilloperawi
) else (
call :resultgui "%jfullpath%" #confirmkillopera
)
	if %cl_close% equ 1 taskkill /f /im opera.exe >nul 2>nul
goto cl_operakd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::DEFINITION DE L'INTERFACE GRAPHIQUE UTILISATEUR (GUI)::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::AVEC IOCNES

::#cl_mainwi
::Window "JaspR" 450 420
::icon "%jpath%\JaspRico.ico"
::Text "SÃ©lectionnez les Ã©lÃ©ments que vous souhaitez nettoyer :" 10 20 350 15
::checkbox "tempfiles" "Fichiers Temporaires" %tempbool% 20 70 180 25
::checkbox "emptytrash" "Vider la Corbeille" %trashbool% 20 100 180 25
::checkbox "recentfiles" "Liste des Fichiers RÃ©cents" %recentbool% 20 130 180 25
::checkbox "logwindows" "Fichiers Journal de Windows" %winlogbool% 200 70 180 25
::checkbox "thumbcache" "Cache des vignettes" %thumbbool% 200 100 180 25
::checkbox "prefetch" "Vieilles donnÃ©es du prefetch" %prefetchbool% 200 130 180 25
::checkbox "hiberstate" "DÃ©sactiver la mise en veille prolongÃ©e" %hiberbool% 20 160 250 25
::Text "Navigateurs :" 20 220 75 15
::radio "yes_clean_nav" "Oui" %yesnavbool% navch 100 215 50 25
::radio "no_clean_nav" "Non" %nonavbool% navch 150 215 50 25
::checkbox "cl_firefox" "Mozilla Firefox" %firefoxbool% 20 260 100 25
::checkbox "cl_chrome" "Google Chrome" %chromebool% 150 260 110 25
::checkbox "cl_edge" "Microsoft Edge" %edgebool% 280 260 100 25
::checkbox "cl_iexplore" "Internet Explorer" %iexplorebool% 20 295 115 25
::checkbox "cl_safari" "Safari" %safaribool% 150 295 100 25
::checkbox "cl_opera" "Opera" %operabool% 280 295 100 25
::Button "back" "Quitter" 75 340 75 25 Popup
::Button "analyse" "Analyser" 178 340 75 25 Popup
::Button "confirm_clean" "Nettoyer" 280 340 75 25 Popup
::#EndGui

::#confirmkillfirefoxwi
::Window "Fermeture de Firefox" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backfirefox" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Firefox ?" 90 100 250 15
::Text "Firefox est actuellement en cours d'exÃ©cution." 77 50 250 15
::Text "Vous devez fermer Firefox avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Firefox" 140 10 150 15
::#EndGui

::#confirmkillchromewi
::Window "Fermeture de Google Chrome" 380 210
::icon "%jpath%\JaspRico.ico"
::Button "backchrome" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Google Chrome ?" 50 100 300 15
::Text "Google Chrome est actuellement en cours d'exÃ©cution." 40 50 300 15
::Text "Vous devez fermer Google Chrome avant de le nettoyer." 37 70 320 15
::Text "Fermeture de Google Chrome" 103 10 175 15
::#EndGui

::#confirmkilledgewi
::Window "Fermeture de Microsoft Edge" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backedge" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Microsoft Edge ?" 75 100 250 15
::Text "Microsoft Edge est actuellement en cours d'exÃ©cution." 52 50 300 15
::Text "Vous devez fermer Microsoft Edge avant de le nettoyer." 49 70 300 15
::Text "Fermeture de Microsoft Edge" 115 10 200 15
::#EndGui

::#confirmkilliexplorewi
::Window "Fermeture de Internet Explorer" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backiexplore" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Internet Explorer ?" 60 100 300 15
::Text "Internet Explorer est actuellement en cours d'exÃ©cution." 42 50 300 15
::Text "Vous devez fermer Internet Explorer avant de le nettoyer." 39 70 300 15
::Text "Fermeture de Internet Explorer" 110 10 175 15
::#EndGui

::#confirmkillsafariwi
::Window "Fermeture de Safari" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backsafari" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Safari ?" 90 100 250 15
::Text "Safari est actuellement en cours d'exÃ©cution." 77 50 250 15
::Text "Vous devez fermer Safari avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Safari" 140 10 150 15
::#EndGui

::#confirmkilloperawi
::Window "Fermeture de Opera" 392 210
::icon "%jpath%\JaspRico.ico"
::Button "backopera" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Opera ?" 90 100 250 15
::Text "Opera est actuellement en cours d'exÃ©cution." 77 50 250 15
::Text "Vous devez fermer Opera avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Opera" 140 10 150 15
::#EndGui



::SANS ICONES

::#cl_main
::Window "JaspR" 450 420
::Text "SÃ©lectionnez les Ã©lÃ©ments que vous souhaitez nettoyer :" 10 20 350 15
::checkbox "tempfiles" "Fichiers Temporaires" %tempbool% 20 70 180 25
::checkbox "emptytrash" "Vider la Corbeille" %trashbool% 20 100 180 25
::checkbox "recentfiles" "Liste des Fichiers RÃ©cents" %recentbool% 20 130 180 25
::checkbox "logwindows" "Fichiers Journal de Windows" %winlogbool% 200 70 180 25
::checkbox "thumbcache" "Cache des vignettes" %thumbbool% 200 100 180 25
::checkbox "prefetch" "Vieilles donnÃ©es du prefetch" %prefetchbool% 200 130 180 25
::checkbox "hiberstate" "DÃ©sactiver la mise en veille prolongÃ©e" %hiberbool% 20 160 250 25
::Text "Navigateurs :" 20 220 75 15
::radio "yes_clean_nav" "Oui" %yesnavbool% navch 100 215 50 25
::radio "no_clean_nav" "Non" %nonavbool% navch 150 215 50 25
::checkbox "cl_firefox" "Mozilla Firefox" %firefoxbool% 20 260 100 25
::checkbox "cl_chrome" "Google Chrome" %chromebool% 150 260 110 25
::checkbox "cl_edge" "Microsoft Edge" %edgebool% 280 260 100 25
::checkbox "cl_iexplore" "Internet Explorer" %iexplorebool% 20 295 115 25
::checkbox "cl_safari" "Safari" %safaribool% 150 295 100 25
::checkbox "cl_opera" "Opera" %operabool% 280 295 100 25
::Button "back" "Quitter" 75 340 75 25 Popup
::Button "analyse" "Analyser" 178 340 75 25 Popup
::Button "confirm_clean" "Nettoyer" 280 340 75 25 Popup
::#EndGui

::#confirmkillfirefox
::Window "Fermeture de Firefox" 392 210
::Button "backfirefox" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Firefox ?" 90 100 250 15
::Text "Firefox est actuellement en cours d'exÃ©cution." 77 50 250 15
::Text "Vous devez fermer Firefox avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Firefox" 140 10 150 15
::#EndGui

::#confirmkillchrome
::Window "Fermeture de Google Chrome" 380 210
::Button "backchrome" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Google Chrome ?" 50 100 300 15
::Text "Google Chrome est actuellement en cours d'exÃ©cution." 40 50 300 15
::Text "Vous devez fermer Google Chrome avant de le nettoyer." 37 70 320 15
::Text "Fermeture de Google Chrome" 103 10 175 15
::#EndGui

::#confirmkilledge
::Window "Fermeture de Microsoft Edge" 392 210
::Button "backedge" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Microsoft Edge ?" 75 100 250 15
::Text "Microsoft Edge est actuellement en cours d'exÃ©cution." 52 50 300 15
::Text "Vous devez fermer Microsoft Edge avant de le nettoyer." 49 70 300 15
::Text "Fermeture de Microsoft Edge" 115 10 200 15
::#EndGui

::#confirmkilliexplore
::Window "Fermeture de Internet Explorer" 392 210
::Button "backiexplore" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Internet Explorer ?" 60 100 300 15
::Text "Internet Explorer est actuellement en cours d'exÃ©cution." 42 50 300 15
::Text "Vous devez fermer Internet Explorer avant de le nettoyer." 39 70 300 15
::Text "Fermeture de Internet Explorer" 110 10 175 15
::#EndGui

::#confirmkillsafari
::Window "Fermeture de Safari" 392 210
::Button "backsafari" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Safari ?" 90 100 250 15
::Text "Safari est actuellement en cours d'exÃ©cution." 77 50 250 15
::Text "Vous devez fermer Safari avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Safari" 140 10 150 15
::#EndGui

::#confirmkillopera
::Window "Fermeture de Opera" 392 210
::Button "backopera" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Opera ?" 90 100 250 15
::Text "Opera est actuellement en cours d'exÃ©cution." 77 50 250 15
::Text "Vous devez fermer Opera avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Opera" 140 10 150 15
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
