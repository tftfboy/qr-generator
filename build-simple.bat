@echo off
setlocal enabledelayedexpansion

echo ===============================================
echo Building QR Generator (No Maven Required)
echo ===============================================
echo.

REM Create directories
if not exist "target\classes" mkdir "target\classes"
if not exist "target\libs" mkdir "target\libs"

echo Step 1: Downloading dependencies...
echo.

REM Download ZXing Core
if not exist "target\libs\core-3.5.3.jar" (
    echo Downloading ZXing Core...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/com/google/zxing/core/3.5.3/core-3.5.3.jar' -OutFile 'target\libs\core-3.5.3.jar'"
)

REM Download ZXing JavaSE
if not exist "target\libs\javase-3.5.3.jar" (
    echo Downloading ZXing JavaSE...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/com/google/zxing/javase/3.5.3/javase-3.5.3.jar' -OutFile 'target\libs\javase-3.5.3.jar'"
)

echo.
echo Step 2: Compiling Java source...
javac -cp "target\libs\*" -d target\classes src\App.java

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)

echo.
echo Step 3: Creating executable JAR...

REM Create manifest
echo Main-Class: App > target\manifest.txt
echo Class-Path: core-3.5.3.jar javase-3.5.3.jar >> target\manifest.txt

REM Create JAR
cd target\classes
jar cfm ..\qr-generator.jar ..\manifest.txt *
cd ..\..

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: JAR creation failed!
    pause
    exit /b 1
)

echo.
echo Step 4: Creating launcher batch file...

REM Create a launcher batch file
(
echo @echo off
echo java -jar "%%~dp0qr-generator.jar"
) > "target\QR-Generator.bat"

REM Create a launcher with hidden console (VBS script)
(
echo Set WshShell = CreateObject^("WScript.Shell"^)
echo WshShell.Run chr^(34^) ^& WshShell.CurrentDirectory ^& "\QR-Generator.bat" ^& Chr^(34^), 0
echo Set WshShell = Nothing
) > "target\QR-Generator.vbs"

echo.
echo ===============================================
echo BUILD SUCCESSFUL!
echo ===============================================
echo.
echo Your application is ready in the 'target' folder:
echo   - qr-generator.jar (main JAR file)
echo   - QR-Generator.bat (launcher with console)
echo   - QR-Generator.vbs (launcher without console - double-click this!)
echo.
echo To run: Double-click target\QR-Generator.vbs
echo.
echo Note: The libs folder must stay with the JAR file.
echo.

pause
