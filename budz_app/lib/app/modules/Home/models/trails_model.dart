import 'package:json_annotation/json_annotation.dart';

part 'trails_model.g.dart';

@JsonSerializable()
class TrailsModel {
  final String? name;
  final String? id;
  final String? imageUrlSquare;

  TrailsModel({
    this.name,
    this.id,
    this.imageUrlSquare,
  });

  factory TrailsModel.fromJson(Map<String, dynamic> json) =>
      _$TrailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TrailsModelToJson(this);
}
