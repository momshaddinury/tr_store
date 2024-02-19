# README

## Overview
This project is a Flutter application that uses Riverpod for state management and dependency injection, Clean Architecture for the project structure, Fake Store API for data retrieval, and Flutter Network for network communication.

## Requirements
To run this project, you need to have the following software installed on your machine:
- Flutter (3.19.0- Stable)
- Dart ('>=3.2.3 <4.0.0')

## Installation
1. Clone the repository to your local machine.
2. Open the project in your preferred IDE.
3. Run `flutter pub get` to install the required dependencies.
4. Make sure to run build_runner to generate files

## Usage
You can run the project on either an emulator or a physical device using the command `flutter run`.

## Project Structure
The project uses Clean Architecture, which separates the code into layers: Presentation, Domain, and Data. Each layer has its own responsibility and is independent of the other layers.

The project structure is as follows:

```
.
└── lib/
    ├── main
    └── src/
        ├── core/
        │   ├── services
        │   ├── state
        │   └── widgets
        └── feature/
            ├── cart/
            │   └── ...
            ├── shared/
            │   ├── category/
            │   │   ├── data/
            │   │   │   ├── data_sources
            │   │   │   ├── models
            │   │   │   └── repositories
            │   │   ├── domain/
            │   │   │   ├── repositories
            │   │   │   └── use_cases
            │   │   └── presentation/
            │   │       ├── providers
            │   │       └── widgets
            │   └── products/
            │       ├── data/
            │       │   ├── data_sources
            │       │   ├── models
            │       │   └── repositories
            │       └── domain/
            │           ├── entity
            │           ├── repositories
            │           └── use_cases
            └── product/
                ├── details/
                │   ├── domain/
                │   │   └── ...
                │   └── presentation/
                │       ├── pages
                │       ├── riverpod
                │       └── widgets
                └── products/
                    ├── domain/
                    │   └── ...
                    └── presentation/
                        └── ...
```
## Dependencies (major)
- flutter_riverpod
- flutter_network
- dartz
- go_router
- sqflite

## Feature
- Fetching all products and categories
- Filtering fetched products by category locally
- Fetching product details and caching the response
- Improving performance of ListView by using *overrideWithValue* and passing const widget
- Navigation using GoRouter
- Caching all the responses
- Handling local cart 

## Dependency Injection, State Management & Caching
The project uses Riverpod for both state management and dependency injection. It allows for easy management of dependencies and makes it easier to test the code. By combining ```FutureProvider.autoDispose``` with ```keepAlive``` state level caching is also acheieved.

## Local Database
For local database this project uses sqflite as a local data source

## Network Communication
The project uses Flutter Network for network communication, which is a custom wrapper plugin with powerful features like caching, redirection, token callback and exception handling.

## Data Retrieval
The project uses the Fake Store API for data retrieval. This is a fake e-commerce API that provides product data that can be used for testing and demonstration purposes.

## Conclusion
This project is an example of how to use Flutter, Riverpod, Clean Architecture, Fake Store API, and Dio together to create a robust and maintainable application.
