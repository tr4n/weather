import 'package:json_annotation/json_annotation.dart';

import 'value.dart';
part 'nearest_area.g.dart';

@JsonSerializable()
class NearestArea {
  @JsonKey(name: "areaName")
  final List<Value> areaNames;
  @JsonKey(name: "country")
  final List<Value> countries;
  @JsonKey(name: "latitude")
  final String latitude;
  @JsonKey(name: "longitude")
  final String longitude;

  NearestArea(this.areaNames, this.countries, this.latitude, this.longitude);

  factory NearestArea.fromJson(Map<String, dynamic> json) =>
      _$NearestAreaFromJson(json);
}
