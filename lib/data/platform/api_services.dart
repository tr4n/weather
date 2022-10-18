import 'package:dio/dio.dart';

import 'response/responses.dart';

class Api {
  static const _baseUrl = "https://wttr.in";

  final Dio dio;

  Api(this.dio) {
    dio
      ..interceptors.add(LogInterceptor(responseBody: true))
      ..options.queryParameters.addAll({"format": "j1"});
  }

  Future<WeatherResponse> getLocaleWeather(String locale) async {
    final response = await dio.get("$_baseUrl/${locale.toUpperCase()}");
    return WeatherResponse.fromJson(response.data);
  }
}
