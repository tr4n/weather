import 'package:json_annotation/json_annotation.dart';

import '../../model/models.dart';

part './weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: "current_condition")
  final List<CurrentCondition> currentConditions;
  @JsonKey(name: "nearest_area")
  final List<NearestArea> nearestArea;
  @JsonKey(name: "weather")
  final List<Weather> weathers;

  WeatherResponse(this.currentConditions, this.nearestArea, this.weathers);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
