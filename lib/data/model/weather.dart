import 'package:json_annotation/json_annotation.dart';

import 'hourly.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  @JsonKey(name: "avgtempC")
  final String avgTempC;
  @JsonKey(name: "maxtempC")
  final String maxtempC;
  @JsonKey(name: "mintempC")
  final String mintempC;
  @JsonKey(name: "date")
  final String date;
  @JsonKey(name: "hourly")
  final List<Hourly> hourlyWeathers;

  @JsonKey(ignore: true)
  DateTime dateTime = DateTime.now();

  Weather(this.avgTempC, this.date, this.hourlyWeathers, this.maxtempC,
      this.mintempC) {
    dateTime = DateTime.parse(date);
  }

  Weather.initDefault()
      : avgTempC = "",
        maxtempC = "",
        mintempC = "",
        date = "",
        hourlyWeathers = List.empty();

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
