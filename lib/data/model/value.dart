import 'package:json_annotation/json_annotation.dart';

part 'value.g.dart';

@JsonSerializable()
class Value {
  @JsonKey(name: "value")
  final String value;

  Value(this.value);

  factory Value.fromJson(Map<String, dynamic> json) =>_$ValueFromJson(json);
}
