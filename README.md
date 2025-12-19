# QR Code Generator

A simple, elegant desktop application for generating QR codes with a modern graphical user interface built with Java Swing.

![Java](https://img.shields.io/badge/Java-11+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Features

- 🎨 Modern, user-friendly GUI with clean design
- 📱 Generate QR codes from any text or URL
- 💾 Save QR codes as PNG images
- 👁️ Real-time preview of generated QR codes
- 🖥️ Cross-platform support (Windows, macOS, Linux)
- 📦 Standalone executable (no Java installation required)


## Installation

### Option 1: Run with Java

**Prerequisites:**
- Java 11 or higher installed on your system

1. Clone the repository:
```bash
git clone https://github.com/tftfboy/qr-generator.git
cd qr-generator
```

2. Build the project:
```bash
mvn clean package
```

3. Run the application:
```bash
java -jar target/qr-generator-1.0-SNAPSHOT.jar
```

### Option 2: Download Executable (Windows)

Download the latest `.exe` file from the [Releases](https://github.com/tftfboy/qr-generator/releases) page and run it directly - no Java installation required!

## Usage

1. Launch the application
2. Enter the text or URL you want to encode in the text field
3. Click **"Generate QR Code"** to create the QR code
4. Preview the generated QR code in the preview area
5. Click **"Save QR Code"** to save the image to your desired location

## Building from Source

### Requirements
- Java JDK 11 or higher
- Maven 3.6 or higher

### Build Commands

**Create JAR file:**
```bash
mvn clean package
```

**Run tests:**
```bash
mvn test
```

**Create standalone executable (Windows):**
```bash
build-exe.bat
```

See [BUILD-INSTRUCTIONS.md](BUILD-INSTRUCTIONS.md) for detailed build instructions.

## Project Structure

```
qr-generator/
├── src/
│   └── App.java           # Main application code
├── target/                # Compiled output
├── pom.xml               # Maven configuration
├── build-exe.bat         # Windows executable builder
└── README.md             # This file
```

## Technology Stack

- **Language:** Java 11+
- **GUI Framework:** Swing
- **QR Code Library:** ZXing (Zebra Crossing) 3.5.3
- **Build Tool:** Maven
- **Packaging:** Maven Shade Plugin

## Dependencies

- [ZXing Core](https://github.com/zxing/zxing) - QR code generation
- [ZXing JavaSE](https://github.com/zxing/zxing) - Image output support

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**tftfboy**
- GitHub: [@tftfboy](https://github.com/tftfboy)

## Acknowledgments

- ZXing library for QR code generation
- Java Swing for the GUI framework

## Support

If you found this project helpful, please give it a ⭐️!

For issues or questions, please open an issue on the [GitHub repository](https://github.com/tftfboy/qr-generator/issues).
