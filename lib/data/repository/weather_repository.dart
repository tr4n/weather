import '../platform/api.dart';

class WeatherRepository {
  final WeatherApi api;

  WeatherRepository({required this.api});

  Future<WeatherResponse> getWeatherData(String locale) =>
      api.getLocaleWeather(locale);
}
