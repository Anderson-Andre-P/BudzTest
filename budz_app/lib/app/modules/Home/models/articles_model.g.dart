// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesModel _$ArticlesModelFromJson(Map<String, dynamic> json) =>
    ArticlesModel(
      categoryName: json['categoryName'] as String?,
      id: json['id'] as String?,
      imageUrlSquare: json['imageUrlSquare'] as String?,
      colorCode: json['colorCode'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ArticlesModelToJson(ArticlesModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'id': instance.id,
      'imageUrlSquare': instance.imageUrlSquare,
      'colorCode': instance.colorCode,
      'title': instance.title,
    };
