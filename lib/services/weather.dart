import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '252ac1ffb2b809b980564da925b6c987';
const weatherApi = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Network network =
        Network('$weatherApi?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await network.getWeatherData();

    return weatherData;
  }

  Future<dynamic> weatherLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    Network network = Network(
        '$weatherApi?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await network.getWeatherData();

    return weatherData;
  }

  // String getWeatherIcon(int condition) {
  //   if (condition < 300) {
  //     return 'rain_thunder';
  //   } else if (condition < 400) {
  //     return 'rain_sun';
  //   } else if (condition < 600) {
  //     return 'rain_cloud';
  //   } else if (condition < 700) {
  //     return 'wind';
  //   } else if (condition < 800) {
  //     return 'rain_snow';
  //   } else if (condition == 800) {
  //     return 'sun_cloud';
  //   } else if (condition > 800 && condition <= 804) {
  //     return 'cloud';
  //   } else {
  //     return 'null';
  //   }
  // }

  String getBackground(int condition) {
    if (condition >= 200 && condition <= 211) {
      return 'thunder';
    } else if (condition >= 212 && condition <= 232) {
      return 'thunder2';
    } else if (condition >= 300 && condition <= 302) {
      return 'drizzle';
    } else if (condition >= 310 && condition <= 312) {
      return 'drizzle2';
    } else if (condition >= 313 && condition <= 321) {
      return 'drizzle3';
    } else if (condition >= 500 && condition <= 504) {
      return 'rain';
    } else if (condition >= 511 && condition <= 531) {
      return 'rain2';
    } else if (condition >= 600 && condition <= 611) {
      return 'snow';
    } else if (condition >= 612 && condition <= 616) {
      return 'snow2';
    } else if (condition >= 620 && condition <= 620) {
      return 'snow3';
    } else if (condition >= 701 && condition <= 741) {
      return 'mist';
    } else if (condition >= 751 && condition <= 781) {
      return 'fog';
    } else if (condition == 800) {
      return 'sun';
    } else if (condition >= 801 && condition <= 802) {
      return 'cloud';
    } else if (condition >= 803 && condition <= 804) {
      return 'cloud2';
    } else {
      return 'clearsky';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
