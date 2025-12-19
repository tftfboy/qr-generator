# QR Generator - Creating Executable

## Method 1: Using Maven (Recommended)

### Prerequisites
- Java JDK 11 or higher
- Apache Maven (download from https://maven.apache.org/download.cgi)

### Steps
1. Run the `build-exe.bat` script:
   ```
   build-exe.bat
   ```

2. The executable will be created at: `target\QR-Generator.exe`

3. You can distribute this .exe file along with a Java 11+ runtime.

---

## Method 2: Manual JAR Creation (If Maven is not available)

### Using your IDE (if you have one):
1. Use your IDE's "Export as JAR" or "Build JAR" feature
2. Make sure to include all dependencies
3. Set the main class as: `App`

### Using command line:
```batch
javac -cp "lib/*" -d target/classes src/App.java
jar cvfe target/qr-generator.jar App -C target/classes .
```

Then create a batch file `run-qr-generator.bat`:
```batch
@echo off
java -jar qr-generator.jar
```

---

## Method 3: Using jpackage (Java 14+)

If you have Java 14 or higher, you can create a native installer:

```batch
jpackage --input target ^
         --name "QR Generator" ^
         --main-jar qr-generator.jar ^
         --main-class App ^
         --type exe ^
         --win-shortcut ^
         --win-menu
```

---

## Running the Application

### After building with Maven:
- Double-click `target\QR-Generator.exe`
- Or run from command line: `target\QR-Generator.exe`

### Requirements:
- Java Runtime Environment (JRE) 11 or higher must be installed on the system
- The .exe launcher will automatically detect the installed Java

---

## Troubleshooting

**"Maven not found"**: Install Maven or add it to your PATH
**"Java not found"**: Install Java JDK 11+ and add to PATH
**Build errors**: Ensure internet connection (Maven downloads dependencies)

---

## Distribution

To distribute your application:
1. Share the `QR-Generator.exe` file (from target folder)
2. Users must have Java 11+ installed
3. Alternatively, bundle a JRE with your application

