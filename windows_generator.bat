@echo off
setlocal enabledelayedexpansion

set "VALID_CODES_FILE=valid_nitro_codes.txt"
set "VALID_CODE_CHANCE=1000"

:: Function to generate a random alphanumeric code of length 16
:generate_code
set "code="
for /L %%i in (1,1,16) do (
    set /A rand=!random! %% 36
    if !rand! lss 10 (
        set /A rand+=48
    ) else (
        set /A rand+=87
    )
    for /f %%j in ('echo prompt $E ^| cmd') do set "code=!code!!rand!"
)
goto :eof

:: Function to save a valid code to the file
:save_valid_code
echo https://discord.gift/%1 >> %VALID_CODES_FILE%
goto :eof

:: Print banner
:print_banner
echo ███▄    █  ██▓▄▄▄█████▓ ██▀███   ▒█████       ▄████ ▓█████  ███▄    █
echo ██ ▀█   █ ▓██▒▓  ██▒ ▓▒▓██ ▒ ██▒▒██▒  ██▒    ██▒ ▀█▒▓█   ▀  ██ ▀█   █
echo ▓██  ▀█ ██▒▒██▒▒ ▓██░ ▒░▓██ ░▄█ ▒▒██░  ██▒   ▒██░▄▄▄░▒███   ▓██  ▀█ ██▒
echo ▓██▒  ▐▌██▒░██░░ ▓██▓ ░ ▒██▀▀█▄  ▒██   ██░   ░▓█  ██▓▒▓█  ▄ ▓██▒  ▐▌██▒
echo ▒██░   ▓██░░██░  ▒██▒ ░ ░██▓ ▒██▒░ ████▓▒░   ░▒▓███▀▒░▒████▒▒██░   ▓██░
echo ░ ▒░   ▒ ▒ ░▓    ▒ ░░   ░ ▒▓ ░▒▓░░ ▒░▒░▒░     ░▒   ▒ ░░ ▒░ ░░ ▒░   ▒ ▒
echo ░ ░░   ░ ▒░ ▒ ░    ░      ░▒ ░ ▒░  ░ ▒ ▒░      ░   ░  ░ ░  ░░ ░░   ░ ▒░
echo    ░   ░ ░  ▒ ░  ░        ░░   ░ ░ ░ ░ ▒     ░ ░   ░    ░      ░   ░ ░
echo          ░  ░              ░         ░ ░           ░    ░  ░         ░
echo.
echo Nitro generator v2 - by Spacy131
goto :eof

:: Print info
:print_info
echo ──────────────────────────────────────────────
echo [INFO] Version: v2
echo [INFO] Creator: Spacy131 (spacy.ws)
echo [INFO] Stop generation: ctrl + c
echo [››››] Do not leave the software on for too long! Risk of computer self-destruction.
echo ──────────────────────────────────────────────
goto :eof

:: Print menu
:print_menu
echo Choose an option:
echo 1. Info
echo 2. Start Generation
echo 3. Exit
goto :eof

:: Main function to start the generator
:start_generator
cls
call :print_banner
echo 💻 Starting the generator...
echo.

set "scanned=0"
:loop
set /A scanned+=1
call :generate_code
set /A rand=%random% %% %VALID_CODE_CHANCE%

:: Simulate random valid code chance (1 in 1000)
if %rand%==1 (
    echo [🎉] Valid Nitro code found! --> https://discord.gift/%code%
    echo      Saved in the file 😏
    call :save_valid_code %code%
) else (
    echo [❌] Invalid code: https://discord.gift/%code%
)

echo 🔍 Codes scanned: %scanned%
echo 🚀 Leave: ctrl + c
timeout /nobreak /t 1 >nul
goto :loop

:: Main menu loop
:main
cls
call :print_banner
call :print_menu
set /p choice="👉 Your choice (1/2/3): "

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
    echo 👋 See you later!
    exit
)
echo ❌ Invalid choice. Press Enter to try again.
pause
goto :main
