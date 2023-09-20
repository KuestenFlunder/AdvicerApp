### README.md

---

# Flutter Advice App

This repository contains the source code for a Flutter application that fetches random advice from an external API and handles theme preferences using shared preferences. The application follows the principles of Clean Architecture and implements the BLoC pattern for state management.

## Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Questions](#questions)
- [License](#license)

## Features

1. **Fetch Random Advice** - The app retrieves random advice from a free API and displays it to the user.
2. **Theme Management** - The app provides functionalities to manage theme preferences using shared preferences.

## Project Structure

The project is structured following the principles of Clean Architecture, which separates the codebase into layers with defined responsibilities:

1. **Domain Layer**
   - `entities`: Defines the data entities such as `AdviceEntity`.
   - `usecases`: Contains the use cases of the application, such as fetching advice from the repository.
   - `failures`: Contains different failure classes that represent various failure states.

2. **Infrastructure Layer**
   - `exceptions`: Defines the custom exceptions thrown by the application.
   - `models`: Contains the data models and serialization logic.
   - `repositories`: Contains the implementation of the repositories defined in the domain layer.
   
3. **Presentation Layer**
   - Utilizes the BLoC pattern to manage the state of the application.
   - Contains BLoC classes that respond to events and update the state of the application.


## Getting Started

To get started with the project, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter_advice_app.git
   ```
2. Navigate to the project directory and install the dependencies:
   ```bash
   cd flutter_advice_app
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

## How to Contribute

We welcome contributions from the community. To contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and submit a pull request.

Before submitting your pull request, please ensure that your code adheres to the project's coding standards and that all tests pass.

## Questions

If you have any questions or ambiguities regarding the project, feel free to open an issue, and we will get back to you as soon as possible.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

