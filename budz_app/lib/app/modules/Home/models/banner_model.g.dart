// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      audience: json['audience'] as String?,
      status: json['status'] as bool?,
      id: json['id'] as String?,
      partner: json['partner'] as String?,
      priority: (json['priority'] as num?)?.toInt(),
      link: json['link'] as String?,
      imageURL: json['imageURL'] as String?,
      targetSpecie: json['targetSpecie'] as String?,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'audience': instance.audience,
      'status': instance.status,
      'id': instance.id,
      'partner': instance.partner,
      'priority': instance.priority,
      'link': instance.link,
      'imageURL': instance.imageURL,
      'targetSpecie': instance.targetSpecie,
    };
