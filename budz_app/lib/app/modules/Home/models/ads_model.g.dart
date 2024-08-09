// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdsModel _$AdsModelFromJson(Map<String, dynamic> json) => AdsModel(
      audience: json['audience'] as String?,
      status: json['status'] as bool?,
      id: json['id'] as String?,
      partner: json['partner'] as String?,
      link: json['link'] as String?,
      imageURL: json['imageURL'] as String?,
      targetSpecie: json['targetSpecie'] as String?,
    );

Map<String, dynamic> _$AdsModelToJson(AdsModel instance) => <String, dynamic>{
      'audience': instance.audience,
      'status': instance.status,
      'id': instance.id,
      'partner': instance.partner,
      'link': instance.link,
      'imageURL': instance.imageURL,
      'targetSpecie': instance.targetSpecie,
    };
