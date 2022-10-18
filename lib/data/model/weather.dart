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
  final List<Hourly> hourly;

  Weather(this.avgTempC, this.date, this.hourly);

  Weather.initDefault()
      : avgTempC = "",
        date = "",
        hourly = List.empty();

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
