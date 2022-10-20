import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:weather/extension/string_ext.dart';

import 'value.dart';

part 'hourly.g.dart';

@JsonSerializable()
class Hourly extends Comparable<Hourly> {
  @JsonKey(name: "weatherDesc")
  final List<Value> weatherDesc;
  @JsonKey(name: "tempC")
  final String tempC;
  @JsonKey(name: "time")
  final String time;

  @JsonKey(ignore: true)
  bool isCurrent = false;

  @JsonKey(ignore: true)
  String hour = "0";

  @JsonKey(ignore: true)
  String minute = "00";

  @JsonKey(ignore: true)
  int hourValue = 0;

  @JsonKey(ignore: true)
  int dayValue = 0;

  Hourly(this.weatherDesc, this.tempC, this.time) {
    final hourMinute = getHourMinute();
    hour = hourMinute["hour"] ?? "0";
    minute = hourMinute["minute"] ?? "00";
    hourValue = int.parse(hour);
  }

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

  Map<String, String> getHourMinute() {
    final fullTime = "0000$time".takeLast(4);
    return {"hour": fullTime.take(2), "minute": fullTime.takeLast(2)};
  }

  @override
  int compareTo(Hourly other) =>
      (dayValue * 100 + hourValue) - (other.dayValue * 100 + other.hourValue);
}
