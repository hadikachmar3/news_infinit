## About me

[![Youtube](https://img.shields.io/static/v1?label=Coding%20with%20Hadi&message=Subscribe&logo=YouTube&color=FF0000&style=for-the-badge)][youtube] 
[![Udemy](https://img.shields.io/badge/Udemy-A435F0?style=for-the-badge&logo=Udemy&logoColor=white)][udemy]
[![Linkedin: HadiKachmar](https://img.shields.io/badge/-CONNECT-blue?style=for-the-badge&logo=Linkedin&link=https://www.linkedin.com/in/hadi-kachmar-27a56a177/)][linkedin]
[![Facebook: HadiKachmar](https://img.shields.io/badge/Facebook-1877F2?style=for-the-badge&logo=facebook&logoColor=white)][facebook]
[![Discord](https://img.shields.io/badge/Discord-blue?style=for-the-badge)][discord]
[![GitHub followers](https://img.shields.io/github/followers/hadikachmar3?logo=GitHub&style=for-the-badge)][github]

# This Project is to Cover Flutter News App

This project is a Flutter application for displaying all news with pagination and the latest news from various categories. It follows clean architecture principles and organizes code into a clear directory structure.

If you are new to Flutter with Rest API you can check [this course](https://www.udemy.com/course/flutter-30rest-api-crash-course-build-a-news-app-from-zero/)

If you find this project useful, please consider giving it a star :star: on GitHub to help spread the word. And if you are interested in following my contributions, give me a follow on GitHub!

## License

This project is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more details.


![Mockup-InfinitNews_smalle](https://github.com/hadikachmar3/news_infinit/assets/38382273/60c0e1bc-ea15-45bd-8c9d-1cdf0241ef44)



## Project Structure

The application is organized into the following directories:

- `lib/`: Main directory for Dart source files.
  - `constants/`: Contains all the constant values used throughout the app.
  - `models/`: Data models that represent the structure of the objects used in the app.
  - `provider/`: State management files using the Provider package.
  - `screens/`: Screen widgets that represent each page of the app.
  - `services/`: Services for handling functions that are used in the whole app, in wide cases this can be extended to be used to cover methods connected to the backend
  - `widgets/`: Custom reusable widget components.
  - `main.dart`: The entry point of the application.

## State Management

This app uses the [Provider](https://pub.dev/packages/provider) package for state management.

Each major feature has its own `Provider` that encapsulates its state and business logic, ensuring a separation of concerns and easier maintainability.

## Download and Test the App

To test the app, pre-built Android APKs are available for download. You can find them in the repository under the following link:

[Android APKs for Testing](https://github.com/hadikachmar3/news_infinit/tree/master/Android%20APKs)

Simply download the appropriate APK file to your Android device and install it to begin testing.

## Usage

To run the app, ensure you have Flutter installed and your environment is set up, then execute:

```bash
flutter run
```

[udemy]: https://www.udemy.com/user/hadi-kachmar-2/
[youtube]: https://www.youtube.com/channel/UCTGDYkqUtgCelc6G09LUm6w
[linkedin]: https://www.linkedin.com/in/hadi-kachmar-27a56a177/
[github]: https://github.com/hadikachmar3
[email]: mailto:flutterer.dev@gmail.com
[facebook]: https://www.facebook.com/Coding-with-Hadi-113431577650864/
[discord]: https://discord.gg/MhnKaY5qdK
