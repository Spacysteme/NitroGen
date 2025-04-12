@echo off
setlocal enabledelayedexpansion

set "VALID_CODES_FILE=valid_nitro_codes.txt"
set "VALID_CODE_CHANCE=1000"
set "SLEEP_DURATION=1.5"  :: Valeur par défaut du cooldown en secondes

:: Fonction pour générer un code aléatoire
:generate_code
set "code="
for /L %%i in (1,1,16) do (
    set /A rand=!random! %% 62
    if !rand! lss 10 (
        set /A rand+=48
    ) else if !rand! lss 36 (
        set /A rand+=87
    ) else (
        set /A rand+=29
    )
    for /f %%j in ('echo prompt $E ^| cmd') do set "code=!code!!rand!"
)
goto :eof

:: Sauvegarder un code valide dans le fichier
:save_valid_code
echo https://discord.gift/%1 >> %VALID_CODES_FILE%
goto :eof

:: Afficher le banner
:print_banner
echo ███▄    █  ██▓▄▄▄█████▓ ██▀███   ▒█████       ▄████ ▓█████  ███▄    █
echo ██ ▀█   █ ▓██▒▓  ██▒ ▓▒▓██ ▒ ██▒▒██▒  ██▒    ██▒ ▀█▒▓█   ▀  ██ ▀█   █
echo ▓██  ▀█ ██▒▒██▒▒ ▓██░ ░░▓██ ░▄█ ▒▒██░  ██▒   ▒██░▄▄▄░▒███   ▓██  ▀█ ██▒
echo ▓██▒  ▐▌██▒░██░░ ▓██▓ ░ ▒██▀▀█▄  ▒██   ██░   ░▓█  ██▓▒▓█  ▄ ▓██▒  ▐▌██▒
echo ▒██░   ▓██░░██░  ▒██▒ ░ ░██▓ ▒██▒░ ████▓▒░   ░▒▓███▀▒░▒████▒▒██░   ▓██░
echo ░ ▒░   ▒ ▒ ░▓    ▒ ░░   ░ ▒▓ ░▒▓░░ ▒░▒░▒░     ░▒   ▒ ░░ ▒░ ░░ ▒░   ▒ ▒
echo ░ ░░   ░ ▒░ ▒ ░    ░      ░▒ ░ ▒░  ░ ▒ ▒░      ░   ░  ░ ░  ░░ ░░   ░ ▒░
echo    ░   ░ ░  ▒ ░  ░        ░░   ░ ░ ░ ░ ▒     ░ ░   ░    ░      ░   ░ ░
echo          ░  ░              ░         ░ ░           ░    ░  ░         ░
echo.
echo Nitro generator v2 - by Spacy131
goto :eof

:: Afficher les infos
:print_info
echo ──────────────────────────────────────────────
echo [INFO] Version: v2
echo [INFO] Creator: Spacy131 (spacy.ws)
echo [INFO] Stop generation: ctrl + c
echo [››››] Do not leave the software on for too long! Risk of computer self-destruction.
echo ──────────────────────────────────────────────
goto :eof

:: Afficher le menu
:print_menu
echo Choose an option:
echo 1. Info
echo 2. Start Generation
echo 3. Change generation speed
echo 4. Exit
goto :eof

:: Démarrer la génération
:start_generator
cls
call :print_banner
echo 💻 Starting the generator (1 code every %SLEEP_DURATION% sec)... 
echo.

set "scanned=0"
:loop
set /A scanned+=1
call :generate_code
set /A rand=%random% %% %VALID_CODE_CHANCE%

:: Simuler la chance d'avoir un code valide (1 sur 1000)
if %rand%==1 (
    echo [🎉] Valid Nitro code found! --> https://discord.gift/%code%
    echo      Saved in the file 😏
    call :save_valid_code %code%
) else (
    echo [❌] Invalid code: https://discord.gift/%code%
)

echo 🔍 Codes scanned: %scanned%
echo 🚀 Leave: ctrl + c

:: Cooldown avant de générer un autre code
ping -n 2 127.0.0.1 >nul
timeout /nobreak /t %SLEEP_DURATION% >nul
goto :loop

:: Changer la vitesse de génération
:change_speed
cls
call :print_banner
echo.
echo Current speed: %SLEEP_DURATION% seconds between codes.
echo.
set /p new_delay="Enter new delay (e.g., 0.5 for 2 codes/sec): "

:: Vérifier que la saisie est valide
if "%new_delay%"=="" (
    echo ❌ Invalid input. Please enter a valid number.
    pause
    goto :main
)

:: Mettre à jour le délai si l'entrée est correcte
set /A "new_delay=%new_delay%"
if %new_delay% GEQ 1 (
    set "SLEEP_DURATION=%new_delay%"
    echo ✅ Speed updated to %SLEEP_DURATION% seconds between codes.
    timeout /nobreak /t 2 >nul
) else (
    echo ❌ Please enter a value greater than or equal to 1 second.
    timeout /nobreak /t 2 >nul
)

goto :main

:: Fonction principale
:main
cls
call :print_banner
call :print_menu
set /p choice="👉 Your choice (1/2/3/4): "

if "%choice%"=="1" (
    call :print_info
    pause
    goto :main
)
if "%choice%"=="2" (
    call :start_generator
    goto :main
)
if "%choice%"=="3" (
    call :change_speed
    goto :main
)
if "%choice%"=="4" (
    echo 👋 See you later!
    exit
)
echo ❌ Invalid choice. Press Enter to try again.
pause
goto :main
