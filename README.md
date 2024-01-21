# Weather App with Flutter

## Overview

This Flutter Weather App is a feature-rich and visually appealing application that provides users with real-time weather information and forecasts for various locations. Leveraging the WeatherAPI.com API, the app ensures accurate and up-to-date weather data.

<p align="center">
  <img src="https://github.com/MohamedAliBouajila/flutter_weather_app/assets/76571658/8d4c8f34-eb86-411c-937d-c89f0a247d5c" width="220" />
  <img src="https://github.com/MohamedAliBouajila/flutter_weather_app/assets/76571658/0ecdcf1a-4fc2-44f8-a53d-1b83f975c355" width="220" />
  <img src="https://github.com/MohamedAliBouajila/flutter_weather_app/assets/76571658/dc89220a-80db-43e7-be85-0e1750915cfd" width="220" />
  <img src="https://github.com/MohamedAliBouajila/flutter_weather_app/assets/76571658/ceda8226-ee37-49cf-a0ae-b23857112eee" width="220" />
</p>


## Features

- **Current Weather:** Stay informed with the latest details on temperature, humidity, wind speed, and more for a specified location.
- **Forecast:** Plan ahead with a 7-day weather forecast, allowing users to prepare for upcoming weather conditions.
- **Location Search:** Easily find weather information by searching for cities, ensuring precise and relevant results.
- **User-Friendly Interface:** The app boasts a clean and intuitive interface, enhancing user experience and accessibility.

## Technologies Used

- **Flutter:** Developed using the Flutter framework, the app provides a seamless and consistent user experience across multiple platforms.
- **Dart:** The programming language used for Flutter app development.
- **WeatherAPI.com API:** Integration with the WeatherAPI.com API ensures accurate and real-time weather data.

## State Management

- **Provider State Management:** The app utilizes the Provider package for state management, enabling efficient sharing of weather information and seamless updates to the weather object in various parts of the application.

## UI and Design

- **3D Icons:** Incorporates visually appealing 3D icons for an enhanced and engaging user interface.
- **Clear UI:** The app features a clear and intuitive user interface, prioritizing ease of use and aesthetic appeal.

## Project Structure

- **Clean Folder Structure:** The project is organized with a clean and logical folder structure, promoting maintainability and ease of navigation.

  ![image](https://github.com/MohamedAliBouajila/flutter_weather_app/assets/76571658/7a60a926-b7fc-4a7c-b832-97cebff8eb70)


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
   - Create a file named `.env` in the project root or under the assets folder and add your API key:
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

<p align="center">⭐ Please star this project for motivation! ⭐</p>
