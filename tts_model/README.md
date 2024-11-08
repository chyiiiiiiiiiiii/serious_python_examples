# TTS Model with Serious Python for Flutter

This project demonstrates how to integrate the `serious_python` package into a Flutter application to handle text-to-speech (TTS) functionalities using Python scripts.

## Table of Contents

- [TTS Model with Serious Python for Flutter](#tts-model-with-serious-python-for-flutter)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Features](#features)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Setup](#setup)
  - [Contributing](#contributing)
  - [License](#license)

## Introduction

This project leverages the `serious_python` package to execute Python scripts within a Flutter application. It is designed to showcase how Python's powerful libraries can be utilized in a mobile app environment, specifically for text-to-speech operations.

## Features

- **Cross-Platform**: Works on both Android and iOS.
- **Python Integration**: Seamlessly run Python scripts from within Flutter.
- **Text-to-Speech**: Convert text to speech using Python's TTS capabilities.

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart: Included with Flutter
- Python: Ensure Python is installed on your system
- `serious_python` package: Version ^0.8.1

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/tts_model_flutter.git
   cd tts_model_flutter
   ```

2. **Install Flutter dependencies:**

   ```bash
   flutter pub get
   ```

3. **Package the Python app:**

   > ℹ️ **Important Reminder**: If you are using `serious_python: ^0.8.1`, ensure you use the command for macOS and not the iOS version, otherwise it will not work.

   For iOS, macOS:

   ```bash
   dart run serious_python:main package app/src -p Darwin --requirements -r,app/src/requirements.txt
   ```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.