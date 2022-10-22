import 'package:json_annotation/json_annotation.dart';
import 'package:weather/extension/list_ext.dart';

import '../../common/pair.dart';
import '../../common/type/weather_type.dart';
import 'models.dart';

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
  @JsonKey(name: "astronomy")
  final List<Astronomy> astronomy;

  @JsonKey(ignore: true)
  DateTime dateTime = DateTime.now();

  @JsonKey(ignore: true)
  WeatherType weatherType = WeatherType.cloudy;

  @JsonKey(ignore: true)
  String description = "";

  Weather(this.avgTempC, this.date, this.hourlyWeathers, this.maxtempC,
      this.mintempC, this.astronomy) {
    dateTime = DateTime.parse(date);
    description = hourlyWeathers
            .groupBy((e) => (e.weatherDesc.firstOrNull()?.value ?? ""))
            .toList()
            .map((e) => Pair(e.first, e.second.length))
            .maxByOrNull((element) => element.second)
            ?.first ??
        "";
    weatherType = WeatherType.fromDescription(description);
  }

  Weather.initDefault()
      : avgTempC = "",
        maxtempC = "",
        mintempC = "",
        date = "",
        hourlyWeathers = List.empty(),
        astronomy = List.empty();

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
