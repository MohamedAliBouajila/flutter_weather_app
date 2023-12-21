# Weather App with Flutter

## Overview

This Flutter Weather App is a simple and intuitive application that allows users to check the current weather conditions and forecasts for different locations. The app leverages the WeatherAPI.com API to fetch real-time weather data.

## Features

- **Current Weather:** Get the latest information on temperature, humidity, wind speed, and more for a specific location.
- **Forecast:** View a 7-day weather forecast to plan ahead.
- **Location Search:** Search for weather information by city name, ensuring accurate and relevant results.
- **User-Friendly Interface:** The app is designed with a clean and user-friendly interface, making it easy for users to navigate and access weather data.

## Technologies Used

- **Flutter:** The app is developed using the Flutter framework, allowing for a seamless and consistent user experience across different platforms.
- **Dart:** Dart is the programming language used for developing the Flutter app.
- **WeatherAPI.com API:** The app utilizes the WeatherAPI.com API to retrieve accurate and up-to-date weather information.

## Getting Started

To run the Weather App locally, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/MohamedAliBouajila/flutter_weather_app
   cd weather-app
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **API Key:**
   - Obtain an API key from [WeatherAPI.com](https://www.weatherapi.com/).
   - Create a file named `.env` in the project root or under assets folder and add your API key:
     ```plaintext
      API_KEY=****************************************
     ```

4. **Run the App:**
   ```bash
   flutter run
   ```

## Configuration

- The app uses the `.env` file to store sensitive information, such as the WeatherAPI.com API key. Ensure this file is kept secure and not shared publicly.

## Contributing

Contributions to the Weather App are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.


## Acknowledgments

- Special thanks to WeatherAPI.com for providing the weather data used in this application.
- Thanks to the Flutter community for their support and contributions.

---

Feel free to customize this README file according to your project's specific details and requirements.
