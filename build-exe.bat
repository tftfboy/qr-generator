@echo off
echo ===============================================
echo Building QR Generator Executable
echo ===============================================
echo.

REM Check if Maven is available
where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Maven is not installed or not in PATH
    echo.
    echo Please install Maven from: https://maven.apache.org/download.cgi
    echo Or add Maven to your PATH environment variable
    echo.
    pause
    exit /b 1
)

echo Building project with Maven...
call mvn clean package

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===============================================
    echo BUILD SUCCESSFUL!
    echo ===============================================
    echo.
    echo Your executable is ready at:
    echo target\QR-Generator.exe
    echo.
    echo You can run it by double-clicking the .exe file
    echo or by running: target\QR-Generator.exe
    echo.
) else (
    echo.
    echo ===============================================
    echo BUILD FAILED!
    echo ===============================================
    echo Please check the error messages above
    echo.
)

pause
