import 'package:json_annotation/json_annotation.dart';

part 'astronomy.g.dart';

@JsonSerializable()
class Astronomy {
  @JsonKey(name: "moonrise")
  final String moonRise;
  @JsonKey(name: "moonset")
  final String moonSet;
  @JsonKey(name: "sunrise")
  final String sunRise;
  @JsonKey(name: "sunset")
  final String sunSet;

  Astronomy(this.moonRise, this.moonSet, this.sunRise, this.sunSet);

  factory Astronomy.fromJson(Map<String, dynamic> json) =>
      _$AstronomyFromJson(json);
}
