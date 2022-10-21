import 'package:json_annotation/json_annotation.dart';
import 'package:weather/extension/list_ext.dart';

import '../../common/type/weather_type.dart';
import 'value.dart';

part 'current_condition.g.dart';

@JsonSerializable()
class CurrentCondition {
  @JsonKey(name: "temp_C")
  final String tempC;
  @JsonKey(name: "weatherDesc")
  final List<Value> weatherDesc;
  @JsonKey(name: "windspeedKmph")
  final String windSpeedKmPh;
  @JsonKey(name: "humidity")
  final String humidity;
  @JsonKey(name: "FeelsLikeC")
  final String feelsLikeC;
  @JsonKey(name: "uvIndex")
  final String uvIndex;

  @JsonKey(ignore: true)
  WeatherType weatherType = WeatherType.cloudy;

  CurrentCondition(this.tempC, this.weatherDesc, this.windSpeedKmPh,
      this.humidity, this.feelsLikeC, this.uvIndex) {
    weatherType =
        WeatherType.fromDescription(weatherDesc.firstOrNull()?.value ?? "");
  }

  // CurrentCondition.initDefault()
  //     : tempC = "",
  //       weatherDesc = List.empty(),
  //       windSpeedKmPh = "",
  //       humidity = "";

  factory CurrentCondition.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionFromJson(json);
}
