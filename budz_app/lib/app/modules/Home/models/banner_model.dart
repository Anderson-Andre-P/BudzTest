import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final String? audience;
  final bool? status;
  final String? id;
  final String? partner;
  final int? priority;
  final String? link;
  final String? imageURL;
  final String? targetSpecie;

  BannerModel({
    this.audience,
    this.status,
    this.id,
    this.partner,
    this.priority,
    this.link,
    this.imageURL,
    this.targetSpecie,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
