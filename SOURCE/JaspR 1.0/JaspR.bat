                                                  ::::::::::::::::::::::::::::::::::::::::::::::::: 
                                                   :::::::::::::::::::::JaspR:::::::::::::::::::::
                                                    ::  Just Another Software to Pull Rubbish  ::
                                                     :::::::::::::::::::::::::::::::::::::::::::
                                                     ::  Programme cr�� par Rapha�l BERTEAUD  ::
                                                     ::   Membre de batch.xoo.it (</Troud>)   ::
                                                     ::   Contact : raph.berteaud@gmail.com   ::
                                                     :::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                    ------------------------------ Creative Commons ------------------------------                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                      Ce code a �t� cr�� par Rapha�l BERTEAUD, il est prot�g� sous la licence :                                       ::
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
:: - de CITER SON AUTEUR (Rapha�l BERTEAUD),                                                                                                            ::
:: - et de NE PAS PUBLIER CE CODE A DES FINS LUCRATIVES SANS AUTORISATION DE L'AUTEUR.                                                                  ::
::                                                                                                                                                      ::
:: Commande externe utilis�e :                                                                                                                          ::
:: -[C#] AGRAFV2.exe :                                                                                                                                  ::
::      Lien de t�l�chargement : http://batch.xoo.it/t5092-C-DEV-AgrafV2-Cr-ateur-d-interface-graphique-TSnake41.htm                                    ::
::      Auteur : TSnake41 (http://batch.xoo.it/profile.php?mode=viewprofile&u=3022)                                                                     ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                    ------------------------------ Creative Commons ------------------------------                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
::VERIFICATION DE L'EXECUTION EN TANT QU'ADMINISTRATEUR
net session >nul 2>nul
if errorlevel 1 (
echo msgbox "Vous devez ex�cuter JaspR en tant qu'administrateur !", 16+vbokonly+vbSystemModal, "JaspR Error" >"%tmp%\adminRor.vbs"
"%tmp%\adminRor.vbs"
del /f /q "%tmp%\adminRor.vbs" >nul 2>nul
exit /B
)
::PARAMETRES DE LA CONSOLE
title JaspR
mode con cols=66 lines=13
echo Initialisation de JaspR, veuillez patienter...
::COPIE DE AGRAFV2 DANS SYSTEM32 S'IL N'EXISTE PAS
if not exist "%windir%\system32\AgrafV2.exe" if exist "%~dp0\AgrafV2.exe" copy "%~dp0\AgrafV2.exe" "%windir%\system32\" /y >nul 2>nul
if not exist "%windir%\system32\JaspRico.ico" if exist "%~dp0\JaspRico.ico" copy "%~dp0\JaspRico.ico" "%windir%\system32\" /y >nul 2>nul
::VARIABLE DU DOSSIER DES UTILISATEURS
for /f "tokens=2-3 delims=\" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^| Find /i "Common AppData"') do set CAD=%systemdrive%\%%a
	if not "%CAD%"=="%systemdrive%\Documents and Settings" set CAD=%systemdrive%\Users
::DEFINITION DES CONSTANTES
set cdir="%~0"
for /f "tokens=*" %%i in ('dir /s /b /a-d "%tmp%\JaspR.bat"') do if exist "%%i" set cdir="%%i"
copy /y %cdir% "%localappdata%" >nul 2>nul
set cdir="%localappdata%\JaspR.bat"
)
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

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::PROGRAMME:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:start_cl_tool
cls   
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo.
echo       ���������������������������������������������������Ŀ
echo       �       Just Another Software to Pull Rubbish       �
echo       �����������������������������������������������������
echo.
echo.
echo.
::CREATION DU RAPPORT (VIDE)
copy nul %tmp%\rapport.tmp /y >nul 2>nul
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
if exist "%windir%\system32\JaspRico.ico" (
call :resultgui %cdir% #cl_mainwi
) else (
call :resultgui %cdir% #cl_main
)

::PROGRESSBAR INITIALE SUR LA CONSOLE
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �                        0%%                        �
echo       ����������������������������������������������������      
echo.
::CONDITIONS ET FONCTIONS A APPELER
	if %confirm_clean% equ 1 (
		if %tempfiles% equ 1 call :tempclean
		if %emptytrash% equ 1 call :trashclean
		if %recentfiles% equ 1 call :recentfileslistclean
		if %logwindows% equ 1 call :logwindowsclean
		if %thumbcache% equ 1 call :thumbcacheclean
		if %prefetch% equ 1 call :prefetchclean
		if %hiberstate% equ 1 (
			call :hiberoff
		) else (
			if not exist "%systemdrive%\hiberfil.sys" powercfg /h on >nul 2>nul
		)
		if %no_clean_nav% equ 1 (
			set "cl_firefox"==""
			set "cl_chrome"==""
			set "cl_edge"==""
			set "cl_iexplore"==""
			set "cl_safari"==""
			set "cl_opera"==""
		) else (
			if %cl_firefox% equ 1 call :cl_firefox
			if %cl_chrome% equ 1 call :cl_chrome
			if %cl_edge% equ 1 call :cl_edge
			if %cl_iexplore% equ 1 call :cl_iexplore
			if %cl_safari% equ 1 call :cl_safari
			if %cl_opera% equ 1 call :cl_opera
		)
	)
	if %analyse% equ 1 (
		if %tempfiles% equ 1 call :tempclean
		if %emptytrash% equ 1 call :trashclean
		if %recentfiles% equ 1 call :recentfileslistclean
		if %logwindows% equ 1 call :logwindowsclean
		if %thumbcache% equ 1 call :thumbcacheclean
		if %prefetch% equ 1 call :prefetchclean
		if %hiberstate% equ 1 (
			call :hiberoff
		) else (
			if not exist "%systemdrive%\hiberfil.sys" powercfg /h on >nul 2>nul
		)
		if %no_clean_nav% equ 1 (
			set "cl_firefox"==""
			set "cl_chrome"==""
			set "cl_edge"==""
			set "cl_iexplore"==""
			set "cl_safari"==""
			set "cl_opera"==""
		) else (
			if %cl_firefox% equ 1 call :cl_firefox
			if %cl_chrome% equ 1 call :cl_chrome
			if %cl_edge% equ 1 call :cl_edge
			if %cl_iexplore% equ 1 call :cl_iexplore
			if %cl_safari% equ 1 call :cl_safari
			if %cl_opera% equ 1 call :cl_opera
		)
	)
	if %back% equ 1 (
		if exist "%tmp%\rapport.tmp" del "%tmp%\rapport.tmp" /f /q >nul 2>nul
		if exist %cdir% del /f /q %cdir% >nul 2>nul
		exit /B
	)
	if %back% equ 0 (
		if %confirm_clean% equ 0 (
			if %analyse% equ 0 (
				if exist "%tmp%\rapport.tmp" del "%tmp%\rapport.tmp" /f /q >nul 2>nul
				if exist %cdir% del /f /q %cdir% >nul 2>nul
				exit /B
			)
		)
	)
::PROGRESSBAR FINALE SUR LA CONSOLE
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ������������������������100%%����������������������۳
echo       ����������������������������������������������������
echo.
::CALCUL DE LA TAILLE TOTALE DE DONNEES (EN MO)
	set /a ttlclnsz=ttlclnsz/1024/1024
	if not defined ttlclnsz set /a ttlclnsz=0
::INSCRIPTION DE LA TAILLE TOTALE DANS LE RAPPORT
	if not %ttlclnsz% gtr 0 (
		if not %analyse% equ 1 (
			echo Aucune donn�e n'a �t� effac�e ! >>"%tmp%\rapport.tmp"
		) else (
			echo Aucune donn�e � supprimer ! >>"%tmp%\rapport.tmp"
		)
	) else (
		echo.>>"%tmp%\rapport.tmp"
			if not %analyse% equ 1 (
				echo Environ %ttlclnsz% Mo supprim�^(s^). >>"%tmp%\rapport.tmp"
			) else (
				echo Environ %ttlclnsz% Mo � supprimer. >>"%tmp%\rapport.tmp"
			)
	)
::CREATION DU SCRIPT DE LECTURE DU RAPPORT
echo Dim objFSO >"%tmp%\clndsz.vbs"
echo Dim objTextFile >>"%tmp%\clndsz.vbs"
echo Dim strText >>"%tmp%\clndsz.vbs"
echo on error resume next >>"%tmp%\clndsz.vbs"
echo Set objFSO = CreateObject("Scripting.FileSystemObject") >>"%tmp%\clndsz.vbs"
echo Set objTextFile = objFSO.OpenTextFile("%tmp%\rapport.tmp", 1) >>"%tmp%\clndsz.vbs"
echo strText = objTextFile.ReadAll >>"%tmp%\clndsz.vbs"
echo objTextFile.Close >>"%tmp%\clndsz.vbs"
echo msgbox strText, 64+vbokonly+vbSystemModal, "JaspR Rapport" >>"%tmp%\clndsz.vbs"
::AFFICHAGE DU RAPPORT (MSGBOX)
"%tmp%\clndsz.vbs"
::SUPPRESSION DU SCRIPT ET DU RAPPORT
del /f /q "%tmp%\clndsz.vbs" >nul 2>nul
del /f /q "%tmp%\rapport.tmp" >nul 2>nul
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

::FONCTION DE NETTOYAGE DES FICHIERS TEMPORAIRES
:tempclean
for /f "tokens=*" %%i in ('dir /s /b /a-d "%windir%\temp" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del "%%i" /f /q >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%windir%\temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

for /f "tokens=*" %%i in ('dir /s /b /a-d "%windir%\System32\config\systemprofile\Local Settings\Temp" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%windir%\System32\config\systemprofile\Local Settings\Temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

for /f "tokens=*" %%i in ('dir /b /ad "%CAD%"') do for /f "tokens=*" %%j in ('dir /s /b /a-d "%CAD%\%%i\LOCALS~1\Temp" 2^>nul') do if exist "%%j" (
	if %%~zj neq 0 set /a ttlclnsz=ttlclnsz+%%~zj
	if not %analyse% equ 1 (
		echo "%%j" |findstr JaspR >nul 2>nul & if not errorlevel 0 del /f /q "%%j" >nul 2>nul
			if exist "%%j" (
				if defined ttlclnsz (
					if %%~zj neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zj
					)
				)
			)
		)
	)
	
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /b /ad "%CAD%"') do for /f "tokens=*" %%j in ('dir /s /b /ad "%CAD%\%%i\LOCALS~1\Temp" 2^>nul') do if exist "%%j" rd /q "%%i" >nul 2>nul

for /f "tokens=*" %%i in ('dir /s /b /a-d "%localappdata%\temp" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		echo "%%j" |findstr JaspR >nul 2>nul & if not errorlevel 0 del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)	
		
if not %analyse% equ 1 for /f "tokens=*" %%i in ('dir /s /b /ad "%localappdata%\temp" 2^>nul') do if exist "%%i" rd /q "%%i" >nul 2>nul

set "cl_temp_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
set /a cl_temp_size=%ttlclnsz%/1024/1024
	if %cl_temp_size% gtr 0 (
		echo Fichiers Temporaires : %cl_temp_size% Mo >>"%tmp%\rapport.tmp"
	)
if %yes_clean_nav% equ 1 (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ������                   10%%                       �
echo       ����������������������������������������������������     
echo.
) else (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ���������                16%%                       �
echo       ����������������������������������������������������
echo.
)
goto:eof

::FONCTION DE NETTOYAGE DES FICHIERS JOURNAL WINDOWS
:logwindowsclean
for /f "tokens=*" %%i in ('dir /s /b /a-d %windir%\*.log 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
for /f "tokens=*" %%i in ('dir /s /b /a-d "%allusersprofile%\Microsoft\Windows\WER\*.wer" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
set "cl_winlog_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
set /a cl_winlog_size=(%ttlclnsz%-%cl_temp_size%*1024*1024)/1024/1024
	if %cl_winlog_size% gtr 0 (
		echo Fichiers Journal : %cl_winlog_size% Mo >>"%tmp%\rapport.tmp"
	)
if %yes_clean_nav% equ 1 (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ���������                17%%                       �
echo       ����������������������������������������������������
echo.
) else (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ����������������         31%%                       �
echo       ����������������������������������������������������
echo.
)
goto:eof

::FONCTION DE NETTOYAGE DU CACHE DES VIGNETTES
:thumbcacheclean
for /f "tokens=*" %%i in ('dir /s /b /a-d "%localappdata%\microsoft\windows\explorer\thumbcache*.db" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
for /f "tokens=*" %%i in ('dir /s /b /a-d "%localappdata%\Microsoft\Windows\Explorer\ThumbCacheToDelete" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
set "cl_thumb_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
set /a cl_thumb_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024)/1024/1024
	if %cl_thumb_size% gtr 0 (
		echo Cache des Vignettes : %cl_thumb_size% Mo >>"%tmp%\rapport.tmp"
	)
if %yes_clean_nav% equ 1 (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �����������              19%%                       �
echo       ����������������������������������������������������
echo.
) else (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ����������������������   42%%                       �
echo       ����������������������������������������������������
echo.
)
goto:eof

::FONCTION DE NETTOYAGE DE LA CORBEILLE
:trashclean
for /f "tokens=*" %%i in ('dir /s /b /a-d %systemdrive%\$Recycle.Bin 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

set "cl_trash_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
set /a cl_trash_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024)/1024/1024
	if %cl_trash_size% gtr 0 (
		echo Corbeille : %cl_trash_size% Mo >>"%tmp%\rapport.tmp"
	)
if %yes_clean_nav% equ 1 (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ����������������         29%%                       �
echo       ����������������������������������������������������
echo.
) else (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������54%%                       �
echo       ����������������������������������������������������
echo.
)
goto:eof

::FONCTION DE NETTOYAGE DE LA LISTE DES FICHIERS RECENTS
:recentfileslistclean
for /f "tokens=*" %%i in ('dir /s /b /a-d "%appdata%\microsoft\windows\recent" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for /f "tokens=*" %%i in ('dir /b /a-d "%windir%\System32\config\systemprofile\Recent\*.*" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q  "%windir%\System32\config\systemprofile\Recent\%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for /f "tokens=*" %%i in ('dir /b /ad "%CAD%"') do for /f "tokens=*" %%j in ('dir /b "%CAD%\%%i\Recent\*.*" 2^>nul') do if exist "%CAD%\%%i\Recent\%%j" (
	if %%~zj neq 0 set /a ttlclnsz=ttlclnsz+%%~zj
	if not %analyse% equ 1 (
		del /f /q "%CAD%\%%i\Recent\%%j" >nul 2>nul
			if exist "%CAD%\%%i\Recent\%%j" (
				if defined ttlclnsz (
					if %%~zj neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zj
					)
				)
			)
		)
	)

set "cl_recent_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
set /a cl_recent_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024)/1024/1024
	if %cl_recent_size% gtr 0 (
		echo Liste des Fichiers R�cents : %cl_recent_size% Mo >>"%tmp%\rapport.tmp"
	)
if %yes_clean_nav% equ 1 (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������      37%%                       �
echo       ����������������������������������������������������
echo.
) else (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������68%%�������                �
echo       ����������������������������������������������������
echo.
)
goto:eof

::FONCTION DE NETTOYAGE DES VIEILLES DONNEES DU PREFETCH
:prefetchclean
for /f "tokens=*" %%i in ('dir /s /b "%windir%\prefetch\" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

set "cl_prefetch_size"==""
if "%ttlclnsz%"=="" set /a ttlclnsz=0
if "%cl_temp_size%"=="" set /a cl_temp_size=0
if "%cl_winlog_size%"=="" set /a cl_winlog_size=0
if "%cl_thumb_size%"=="" set /a cl_thumb_size=0
if "%cl_trash_size%"=="" set /a cl_trash_size=0
if "%cl_recent_size%"=="" set /a cl_recent_size=0
set /a cl_prefetch_size=(%ttlclnsz%-%cl_temp_size%*1024*1024-%cl_winlog_size%*1024*1024-%cl_thumb_size%*1024*1024-%cl_trash_size%*1024*1024-%cl_recent_size%*1024*1024)/1024/1024
	if %cl_prefetch_size% gtr 0 (
		echo Vieilles Donn�es du Prefetch : %cl_prefetch_size% Mo >>"%tmp%\rapport.tmp"
	)
if %yes_clean_nav% equ 1 (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ������������������������ 46%%                       �
echo       ����������������������������������������������������
echo.
) else (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������82%%��������������         �
echo       ����������������������������������������������������
echo.
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
		if %hiberfilsize% gtr 0 echo Supp. Mise en Veille Prolong�e : %hiberfilsizemo% Mo >>"%tmp%\rapport.tmp"
	)
if %yes_clean_nav% equ 1 (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������55%%��                     �
echo       ����������������������������������������������������
echo.
) else (
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ������������������������100%%����������������������۳
echo       ����������������������������������������������������
echo.
)
goto:eof

::FONCTION DE NETTOYAGE DE FIREFOX
:cl_firefox
tasklist |find "firefox.exe" >nul 2>nul & if not errorlevel 1 goto firefoxopened

:cl_firefoxkd

for /f "tokens=*" %%i in ('dir /s /b /a-d "%localfirefoxdir%" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
for /f "tokens=*" %%i in ('dir /s /b /a-d "%roamingfirefoxdir%\*.sqlite" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

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
		echo Firefox : %cl_firefox_size% Mo >>"%tmp%\rapport.tmp"
	)
	
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������64%%�����                  �
echo       ����������������������������������������������������
echo.

goto:eof

:firefoxopened
set "backfirefox"==""
set "cl_close"==""
if exist "%windir%\system32\JaspRico.ico" (
call :resultgui %cdir% #confirmkillfirefoxwi
) else (
call :resultgui %cdir% #confirmkillfirefox
)
	if %cl_close% equ 1 taskkill /f /im firefox.exe >nul 2>nul
goto cl_firefoxkd

::FONCTION DE NETTOYAGE DE GOOGLE CHROME
:cl_chrome
tasklist |find "chrome.exe" >nul 2>nul & if not errorlevel 1 goto chromeopened

:cl_chromekd

for /f "tokens=*" %%i in ('dir /s /b /a-d "%localchromedir%" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

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
		echo Google Chrome : %cl_chrome_size% Mo >>"%tmp%\rapport.tmp"
	)

cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������72%%���������              �
echo       ����������������������������������������������������
echo.

goto:eof

:chromeopened
set "backchrome"==""
set "cl_close"==""
if exist "%windir%\system32\JaspRico.ico" (
call :resultgui %cdir% #confirmkillchromewi
) else (
call :resultgui %cdir% #confirmkillchrome
)
	if %cl_close% equ 1 taskkill /f /im chrome.exe >nul 2>nul
goto cl_chromekd

::FONCTION DE NETTOYAGE DE MICROSOFT EDGE
:cl_edge
tasklist |find "MicrosoftEdge.exe" || tasklist |find "MicrosoftEdgeCP.exe" >nul 2>nul & if not errorlevel 1 goto edgeopened

:cl_edgekd

for /f "tokens=*" %%i in ('dir /b /ad "%localappdata%\Packages\Microsoft.MicrosoftEdge*" 2^>nul') do for /f "tokens=*" %%j in ('dir /s /a-d /b "%localappdata%\Packages\%%i\AC" 2^>nul') do if exist "%%j" (
	if %%~zj neq 0 set /a ttlclnsz=ttlclnsz+%%~zj
	if not %analyse% equ 1 (
		del /f /q "%%j" >nul 2>nul
			if exist "%%j" (
				if defined ttlclnsz (
					if %%~zj neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zj
					)
				)
			)
		)
	)
	
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
		echo Microsoft Edge : %cl_edge_size% Mo >>"%tmp%\rapport.tmp"
	)

cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������79%%������������           �
echo       ����������������������������������������������������
echo.
	
goto:eof

:edgeopened
set "backedge"==""
set "cl_close"==""
if exist "%windir%\system32\JaspRico.ico" (
call :resultgui %cdir% #confirmkilledgewi
) else (
call :resultgui %cdir% #confirmkilledge
)
	if %cl_close% equ 1 taskkill /f /im MicrosoftEdge.exe >nul 2>nul & taskkill /f /im MicrosoftEdgeCP.exe >nul 2>nul
goto cl_edgekd

::FONCTION DE NETTOYAGE D'INTERNET EXPLORER
:cl_iexplore
tasklist |find "iexplore.exe" >nul 2>nul & if not errorlevel 1 goto iexploreopened

:cl_iexplorekd

for %%i in ("%localIEdir%") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for %%i in ("%localhistoryIEdir%") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for %%i in ("%localtempIEdir%") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for %%i in ("%roamingcookiesIEdir%") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

	if not %analyse% equ 1 del "%localappdata%\Microsoft\Windows\Temporary Internet Files\*.*" /f /s /q >nul 2>nul

for /f "tokens=*" %%i in ('dir /s /b /a-d "%localappdata%\microsoft\windows\inetcache" 2^>nul') do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

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
		echo Internet Explorer : %cl_iexplore_size% Mo >>"%tmp%\rapport.tmp"
	)
	
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������87%%�����������������      �
echo       ����������������������������������������������������
echo.
	
goto:eof

:iexploreopened
set "backiexplore"==""
set "cl_close"==""
if exist "%windir%\system32\JaspRico.ico" (
call :resultgui %cdir% #confirmkilliexplorewi
) else (
call :resultgui %cdir% #confirmkilliexplore
)
	if %cl_close% equ 1 taskkill /f /im iexplore.exe >nul 2>nul
goto cl_iexplorekd

::FONCTION DE NETTOYAGE DE SAFARI
:cl_safari
tasklist |find "safari.exe" >nul 2>nul & if not errorlevel 1 goto safariopened

:cl_safarikd

for %%i in ("%localhistorysafaridir%") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for %%i in ("%localsafaridir%\Cache.db") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for %%i in ("%localsafaridir%\WebpageIcons.db") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for %%i in ("%roamingsafaridir%") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)
	
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
		echo Safari : %cl_safari_size% Mo >>"%tmp%\rapport.tmp"
	)
	
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       �������������������������92%%�������������������    �
echo       ����������������������������������������������������
echo.
	
goto:eof

:safariopened
set "backsafari"==""
set "cl_close"==""
if exist "%windir%\system32\JaspRico.ico" (
call :resultgui %cdir% #confirmkillsafariwi
) else (
call :resultgui %cdir% #confirmkillsafari
)
	if %cl_close% equ 1 taskkill /f /im safari.exe >nul 2>nul
goto cl_safarikd

::FONCTION DE NETTOYAGE D'OPERA
:cl_opera
tasklist |find "opera.exe" >nul 2>nul & if not errorlevel 1 goto operaopened

:cl_operakd

for %%i in ("%localoperadir%") do if exist "%%i" (
	if exist "%%i" set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

for %%i in ("%roamingoperadir%") do if exist "%%i" (
	if %%~zi neq 0 set /a ttlclnsz=ttlclnsz+%%~zi
	if not %analyse% equ 1 (
		del /f /q /s "%%i" >nul 2>nul
			if exist "%%i" (
				if defined ttlclnsz (
					if %%~zi neq 0 (
						set /a ttlclnsz=ttlclnsz-%%~zi
					)
				)
			)
		)
	)

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
		echo Opera : %cl_opera_size% Mo >>"%tmp%\rapport.tmp"
	)
	
cls
echo.
echo                      ���������������������ͻ
echo                      �        JaspR        �
echo                      ���������������������ͼ
echo.
echo         Cette op�ration peut prendre un certain temps...
echo       Asseyez-vous donc confortablement, et d�tendez-vous.
echo.
echo       ��������������������������������������������������Ŀ
echo       ������������������������100%%����������������������۳
echo       ����������������������������������������������������
echo.
	
goto:eof

:operaopened
set "backopera"==""
set "cl_close"==""
if exist "%windir%\system32\JaspRico.ico" (
call :resultgui %cdir% #confirmkilloperawi
) else (
call :resultgui %cdir% #confirmkillopera
)
	if %cl_close% equ 1 taskkill /f /im opera.exe >nul 2>nul
goto cl_operakd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::DEFINITION DE L'INTERFACE GRAPHIQUE UTILISATEUR (GUI)::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::AVEC IOCNES

::#cl_mainwi
::Window "JaspR" 450 420
::icon "C:\windows\system32\JaspRico.ico"
::Text "Sélectionnez les éléments que vous souhaitez nettoyer :" 10 20 350 15
::checkbox "tempfiles" "Fichiers Temporaires" TRUE 20 70 180 25
::checkbox "emptytrash" "Vider la Corbeille" TRUE 20 100 180 25
::checkbox "recentfiles" "Liste des Fichiers Récents" TRUE 20 130 180 25
::checkbox "logwindows" "Fichiers Journal de Windows" TRUE 200 70 180 25
::checkbox "thumbcache" "Cache des vignettes" TRUE 200 100 180 25
::checkbox "prefetch" "Vieilles données du prefetch" TRUE 200 130 180 25
::checkbox "hiberstate" "Désactiver la mise en veille prolongée" FALSE 20 160 250 25
::Text "Navigateurs :" 20 220 75 15
::radio "yes_clean_nav" "Oui" TRUE navch 100 215 50 25
::radio "no_clean_nav" "Non" FALSE navch 150 215 50 25
::checkbox "cl_firefox" "Mozilla Firefox" FALSE 20 260 100 25
::checkbox "cl_chrome" "Google Chrome" FALSE 150 260 110 25
::checkbox "cl_edge" "Microsoft Edge" FALSE 280 260 100 25
::checkbox "cl_iexplore" "Internet Explorer" FALSE 20 295 115 25
::checkbox "cl_safari" "Safari" FALSE 150 295 100 25
::checkbox "cl_opera" "Opera" FALSE 280 295 100 25
::Button "back" "Quitter" 75 340 75 25 Popup
::Button "analyse" "Analyser" 178 340 75 25 Popup
::Button "confirm_clean" "Nettoyer" 280 340 75 25 Popup
::#EndGui

::#confirmkillfirefoxwi
::Window "Fermeture de Firefox" 392 210
::icon "C:\windows\system32\JaspRico.ico"
::Button "backfirefox" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Firefox ?" 90 100 250 15
::Text "Firefox est actuellement en cours d'exécution." 77 50 250 15
::Text "Vous devez fermer Firefox avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Firefox" 140 10 150 15
::#EndGui

::#confirmkillchromewi
::Window "Fermeture de Google Chrome" 380 210
::icon "C:\windows\system32\JaspRico.ico"
::Button "backchrome" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Google Chrome ?" 50 100 300 15
::Text "Google Chrome est actuellement en cours d'exécution." 40 50 300 15
::Text "Vous devez fermer Google Chrome avant de le nettoyer." 37 70 320 15
::Text "Fermeture de Google Chrome" 103 10 175 15
::#EndGui

::#confirmkilledgewi
::Window "Fermeture de Microsoft Edge" 392 210
::icon "C:\windows\system32\JaspRico.ico"
::Button "backedge" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Microsoft Edge ?" 75 100 250 15
::Text "Microsoft Edge est actuellement en cours d'exécution." 52 50 300 15
::Text "Vous devez fermer Microsoft Edge avant de le nettoyer." 49 70 300 15
::Text "Fermeture de Microsoft Edge" 115 10 200 15
::#EndGui

::#confirmkilliexplorewi
::Window "Fermeture de Internet Explorer" 392 210
::icon "C:\windows\system32\JaspRico.ico"
::Button "backiexplore" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Internet Explorer ?" 60 100 300 15
::Text "Internet Explorer est actuellement en cours d'exécution." 42 50 300 15
::Text "Vous devez fermer Internet Explorer avant de le nettoyer." 39 70 300 15
::Text "Fermeture de Internet Explorer" 110 10 175 15
::#EndGui

::#confirmkillsafariwi
::Window "Fermeture de Safari" 392 210
::icon "C:\windows\system32\JaspRico.ico"
::Button "backsafari" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Safari ?" 90 100 250 15
::Text "Safari est actuellement en cours d'exécution." 77 50 250 15
::Text "Vous devez fermer Safari avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Safari" 140 10 150 15
::#EndGui

::#confirmkilloperawi
::Window "Fermeture de Opera" 392 210
::icon "C:\windows\system32\JaspRico.ico"
::Button "backopera" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Opera ?" 90 100 250 15
::Text "Opera est actuellement en cours d'exécution." 77 50 250 15
::Text "Vous devez fermer Opera avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Opera" 140 10 150 15
::#EndGui



::SANS ICONES

::#cl_main
::Window "JaspR" 450 420
::Text "Sélectionnez les éléments que vous souhaitez nettoyer :" 10 20 350 15
::checkbox "tempfiles" "Fichiers Temporaires" TRUE 20 70 180 25
::checkbox "emptytrash" "Vider la Corbeille" TRUE 20 100 180 25
::checkbox "recentfiles" "Liste des Fichiers Récents" TRUE 20 130 180 25
::checkbox "logwindows" "Fichiers Journal de Windows" TRUE 200 70 180 25
::checkbox "thumbcache" "Cache des vignettes" TRUE 200 100 180 25
::checkbox "prefetch" "Vieilles données du prefetch" TRUE 200 130 180 25
::checkbox "hiberstate" "Désactiver la mise en veille prolongée" FALSE 20 160 250 25
::Text "Navigateurs :" 20 220 75 15
::radio "yes_clean_nav" "Oui" TRUE navch 100 215 50 25
::radio "no_clean_nav" "Non" FALSE navch 150 215 50 25
::checkbox "cl_firefox" "Mozilla Firefox" FALSE 20 260 100 25
::checkbox "cl_chrome" "Google Chrome" FALSE 150 260 110 25
::checkbox "cl_edge" "Microsoft Edge" FALSE 280 260 100 25
::checkbox "cl_iexplore" "Internet Explorer" FALSE 20 295 115 25
::checkbox "cl_safari" "Safari" FALSE 150 295 100 25
::checkbox "cl_opera" "Opera" FALSE 280 295 100 25
::Button "back" "Quitter" 75 340 75 25 Popup
::Button "analyse" "Analyser" 178 340 75 25 Popup
::Button "confirm_clean" "Nettoyer" 280 340 75 25 Popup
::#EndGui

::#confirmkillfirefox
::Window "Fermeture de Firefox" 392 210
::Button "backfirefox" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Firefox ?" 90 100 250 15
::Text "Firefox est actuellement en cours d'exécution." 77 50 250 15
::Text "Vous devez fermer Firefox avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Firefox" 140 10 150 15
::#EndGui

::#confirmkillchrome
::Window "Fermeture de Google Chrome" 380 210
::Button "backchrome" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Google Chrome ?" 50 100 300 15
::Text "Google Chrome est actuellement en cours d'exécution." 40 50 300 15
::Text "Vous devez fermer Google Chrome avant de le nettoyer." 37 70 320 15
::Text "Fermeture de Google Chrome" 103 10 175 15
::#EndGui

::#confirmkilledge
::Window "Fermeture de Microsoft Edge" 392 210
::Button "backedge" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Microsoft Edge ?" 75 100 250 15
::Text "Microsoft Edge est actuellement en cours d'exécution." 52 50 300 15
::Text "Vous devez fermer Microsoft Edge avant de le nettoyer." 49 70 300 15
::Text "Fermeture de Microsoft Edge" 115 10 200 15
::#EndGui

::#confirmkilliexplore
::Window "Fermeture de Internet Explorer" 392 210
::Button "backiexplore" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Internet Explorer ?" 60 100 300 15
::Text "Internet Explorer est actuellement en cours d'exécution." 42 50 300 15
::Text "Vous devez fermer Internet Explorer avant de le nettoyer." 39 70 300 15
::Text "Fermeture de Internet Explorer" 110 10 175 15
::#EndGui

::#confirmkillsafari
::Window "Fermeture de Safari" 392 210
::Button "backsafari" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Safari ?" 90 100 250 15
::Text "Safari est actuellement en cours d'exécution." 77 50 250 15
::Text "Vous devez fermer Safari avant de le nettoyer." 74 70 300 15
::Text "Fermeture de Safari" 140 10 150 15
::#EndGui

::#confirmkillopera
::Window "Fermeture de Opera" 392 210
::Button "backopera" "Non" 105 130 75 25
::Button "cl_close" "Oui" 195 130 75 25
::Text "Voulez-vous que JaspR ferme Opera ?" 90 100 250 15
::Text "Opera est actuellement en cours d'exécution." 77 50 250 15
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
