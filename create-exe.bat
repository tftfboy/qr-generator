@echo off
echo Creating Windows Executable Wrapper...
echo.

REM Check if JAR exists
if not exist "target\qr-generator.jar" (
    echo ERROR: JAR file not found!
    echo Please run build-simple.bat first.
    pause
    exit /b 1
)

echo Creating QR-Generator.exe...

REM This creates a C# wrapper that will be compiled to .exe
powershell -Command "$code = @'^
using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

class Program {
    [STAThread]
    static void Main() {
        try {
            string jarPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, \"qr-generator.jar\");
            
            if (!File.Exists(jarPath)) {
                MessageBox.Show(\"QR Generator JAR file not found!\", \"Error\", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = \"javaw\";
            psi.Arguments = \"-jar \\\"\" + jarPath + \"\\\"\";
            psi.UseShellExecute = false;
            psi.CreateNoWindow = true;
            psi.WorkingDirectory = AppDomain.CurrentDomain.BaseDirectory;
            
            Process process = Process.Start(psi);
        } catch (Exception ex) {
            MessageBox.Show(\"Error starting QR Generator: \" + ex.Message + \"\n\nMake sure Java is installed.\", \"Error\", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}
^@; Add-Type -TypeDefinition $code -ReferencedAssemblies System.Windows.Forms -OutputAssembly 'target\QR-Generator.exe' -OutputType WindowsApplication"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===============================================
    echo SUCCESS!
    echo ===============================================
    echo.
    echo QR-Generator.exe has been created!
    echo Location: target\QR-Generator.exe
    echo.
    echo You can now double-click the .exe to run the application.
    echo.
    echo IMPORTANT: Keep these files together:
    echo   - QR-Generator.exe
    echo   - qr-generator.jar
    echo   - libs folder (with dependencies)
    echo.
) else (
    echo.
    echo ERROR: Failed to create .exe
    echo.
)

pause
