import 'package:json_annotation/json_annotation.dart';

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

  CurrentCondition(
      this.tempC, this.weatherDesc, this.windSpeedKmPh, this.humidity);

  CurrentCondition.initDefault()
      : tempC = "",
        weatherDesc = List.empty(),
        windSpeedKmPh = "",
        humidity = "";

  factory CurrentCondition.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionFromJson(json);
}
