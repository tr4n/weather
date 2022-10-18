import 'package:json_annotation/json_annotation.dart';

import 'value.dart';
part 'hourly.g.dart';

@JsonSerializable()
class Hourly {
  @JsonKey(name: "weatherDesc")
  final List<Value> weatherDesc;
  @JsonKey(name: "tempC")
  final String tempC;
  @JsonKey(name: "time")
  final String time;

  Hourly(this.weatherDesc, this.tempC, this.time);

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
}
