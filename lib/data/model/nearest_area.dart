import 'package:geocoding/geocoding.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/extension/list_ext.dart';

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

  @JsonKey(ignore: true)
  List<Placemark> cities = List.empty();

  NearestArea(this.areaNames, this.countries, this.latitude, this.longitude);

  String getLocationName() {
    final placeMark = cities.firstOrNull();
    if (placeMark == null) return "";
    return "${placeMark.administrativeArea}, ${placeMark.country}";
  }

  factory NearestArea.fromJson(Map<String, dynamic> json) =>
      _$NearestAreaFromJson(json);
}
