# QR Generator - Executable Application

## ✅ Your Application is Ready!

Your QR Generator is now available as a Windows executable (`.exe`) file!

## 🚀 How to Run

**Option 1: Double-click the .exe file (Recommended)**
- Navigate to: `target\QR-Generator.exe`
- Double-click to run

**Option 2: Double-click the .vbs file (No console window)**
- Navigate to: `target\QR-Generator.vbs`
- Double-click to run (launches without console)

**Option 3: Run from command line**
```
target\QR-Generator.exe
```

## 📦 What Was Created

In the `target` folder, you'll find:
- **QR-Generator.exe** - Windows executable (main launcher)
- **qr-generator.jar** - Java application JAR file
- **libs/** - Folder with required dependencies
- **QR-Generator.bat** - Batch launcher (shows console)
- **QR-Generator.vbs** - VBS launcher (no console)

## 📋 Requirements

- **Java Runtime Environment (JRE)** version 11 or higher must be installed
- Your system already has Java 21 installed ✓

## 📤 Distribution

To share your application with others:

### Complete Package (Recommended)
Share the entire `target` folder containing:
- `QR-Generator.exe`
- `qr-generator.jar`
- `libs/` folder

### ZIP Distribution
1. Create a ZIP file with:
   - QR-Generator.exe
   - qr-generator.jar
   - libs folder
2. Recipients need Java 11+ installed to run

### Standalone Executable (Advanced)
If you want a true standalone .exe (no Java required), consider:
- Using jpackage to bundle JRE (see BUILD-INSTRUCTIONS.md)
- Using GraalVM native-image for native compilation

## 🔧 Rebuilding

If you make changes to the code:

1. Run the build script:
   ```
   build-simple.bat
   ```

2. Create the exe wrapper:
   ```
   powershell -ExecutionPolicy Bypass -File create-exe.ps1
   ```

Or use the combined approach if you have Maven installed:
   ```
   build-exe.bat
   ```

## ❗ Troubleshooting

**"Java not found" error**
- Install Java JRE/JDK 11 or higher
- Add Java to system PATH

**"JAR file not found" error**
- Make sure `qr-generator.jar` is in the same folder as the .exe
- Don't move or rename the JAR file

**Dependencies missing**
- Keep the `libs` folder in the same directory
- The libs folder contains required ZXing libraries

## 📄 Files Created During Build

- `build-simple.bat` - Simple build script (no Maven required)
- `create-exe.bat` - Batch script wrapper for .exe creation
- `create-exe.ps1` - PowerShell script to create .exe
- `build-exe.bat` - Maven-based build script (requires Maven)
- `BUILD-INSTRUCTIONS.md` - Detailed build instructions

## 🎯 Using the Application

1. Launch QR-Generator.exe
2. Enter a URL or text in the "Link" field
3. Click "Generate" to create the QR code
4. Click "Save PNG" to save the QR code image

Enjoy your QR Generator! 🎉
