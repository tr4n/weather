import 'package:json_annotation/json_annotation.dart';

import 'hourly.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  @JsonKey(name: "avgtempC")
  final String avgTempC;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "hourly")
  final List<Hourly> hourlyWeathers;

  Weather(this.avgTempC, this.date, this.hourlyWeathers);

  Weather.initDefault()
      : avgTempC = "",
        date = "",
        hourlyWeathers = List.empty();

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
