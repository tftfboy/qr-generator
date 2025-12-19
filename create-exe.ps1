# PowerShell script to create Windows executable wrapper

Write-Host "Creating Windows Executable Wrapper..." -ForegroundColor Cyan
Write-Host ""

# Check if JAR exists
if (-not (Test-Path "target\qr-generator.jar")) {
    Write-Host "ERROR: JAR file not found!" -ForegroundColor Red
    Write-Host "Please run build-simple.bat first."
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Compiling QR-Generator.exe..." -ForegroundColor Yellow

$code = @"
using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

class Program {
    [STAThread]
    static void Main() {
        try {
            string jarPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "qr-generator.jar");
            
            if (!File.Exists(jarPath)) {
                MessageBox.Show("QR Generator JAR file not found!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "javaw";
            psi.Arguments = "-jar \"" + jarPath + "\"";
            psi.UseShellExecute = false;
            psi.CreateNoWindow = true;
            psi.WorkingDirectory = AppDomain.CurrentDomain.BaseDirectory;
            
            Process process = Process.Start(psi);
        } catch (Exception ex) {
            MessageBox.Show("Error starting QR Generator: " + ex.Message + "\n\nMake sure Java is installed.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}
"@

try {
    Add-Type -TypeDefinition $code -ReferencedAssemblies System.Windows.Forms -OutputAssembly "target\QR-Generator.exe" -OutputType WindowsApplication
    
    Write-Host ""
    Write-Host "===============================================" -ForegroundColor Green
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host "===============================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "QR-Generator.exe has been created!" -ForegroundColor Green
    Write-Host "Location: target\QR-Generator.exe" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "You can now double-click the .exe to run the application."
    Write-Host ""
    Write-Host "IMPORTANT: Keep these files together:" -ForegroundColor Yellow
    Write-Host "  - QR-Generator.exe"
    Write-Host "  - qr-generator.jar"
    Write-Host "  - libs folder (with dependencies)"
    Write-Host ""
} catch {
    Write-Host ""
    Write-Host "ERROR: Failed to create .exe" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
}

Read-Host "Press Enter to exit"
