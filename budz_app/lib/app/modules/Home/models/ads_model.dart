import 'package:json_annotation/json_annotation.dart';

part 'ads_model.g.dart';

@JsonSerializable()
class AdsModel {
  final String? audience;
  final bool? status;
  final String? id;
  final String? partner;
  final String? link;
  final String? imageURL;
  final String? targetSpecie;

  AdsModel({
    this.audience,
    this.status,
    this.id,
    this.partner,
    this.link,
    this.imageURL,
    this.targetSpecie,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) =>
      _$AdsModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdsModelToJson(this);
}
