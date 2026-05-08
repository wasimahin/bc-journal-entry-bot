@echo off

title BC Journal Entry Bot - Launcher

color 0A



echo.

echo  ================================================

echo   BC Journal Entry Bot  v2.3.0

echo   Associated Students, Inc. ^| CSULB

echo  ================================================

echo.



where py >nul 2>&1

if %ERRORLEVEL%==0 (

    set PYTHON=py -3

) else (

    where python >nul 2>&1

    if %ERRORLEVEL%==0 (

        set PYTHON=python

    ) else (

        echo ERROR: Python not found.

        echo Install Python 3.11+ from https://python.org

        echo.

        pause

        exit /b 1

    )

)



echo Python command: %PYTHON%

%PYTHON% -c "import sys; v=sys.version_info; print(f'Python {v.major}.{v.minor}.{v.micro}'); exit(0 if v>=(3,11) else 1)" 2>&1

if %ERRORLEVEL% NEQ 0 (

    echo.

    echo ERROR: Python 3.11 or higher required.

    echo.

    pause

    exit /b 1

)



echo.

echo Checking required libraries...

%PYTHON% -c "import customtkinter, pdfplumber, pyautogui, pyperclip, openpyxl, fitz, PIL, pypdf" 2>nul

if %ERRORLEVEL% NEQ 0 (

    echo.

    echo Installing required libraries...

    %PYTHON% -m pip install customtkinter pdfplumber pyautogui pyperclip openpyxl pymupdf pillow pypdf

    if %ERRORLEVEL% NEQ 0 (

        echo.

        echo ERROR: pip install failed.

        echo Try manually:

        echo   pip install customtkinter pdfplumber pyautogui pyperclip openpyxl pymupdf pillow pypdf

        echo.

        pause

        exit /b 1

    )

)



%PYTHON% -c "import keyboard" 2>nul

if %ERRORLEVEL% NEQ 0 (

    echo NOTE: keyboard library not installed - ALT+F8 will only work while app is focused.

    echo To enable global ALT+F8: pip install keyboard

    echo.

)



echo Starting BC Journal Entry Bot...

echo ------------------------------------------------

%PYTHON% "%~dp0je_bot.py" 2>&1

set EXIT_CODE=%ERRORLEVEL%

if %EXIT_CODE% NEQ 0 (

    echo.

    echo ================================================

    echo APPLICATION EXITED WITH ERROR (code %EXIT_CODE%)

    echo ================================================

    if exist "%~dp0startup_error.log" (

        echo.

        echo --- startup_error.log contents ---

        type "%~dp0startup_error.log"

        echo ----------------------------------

    )

    echo.

    pause

)


