import 'package:json_annotation/json_annotation.dart';

part 'articles_model.g.dart';

@JsonSerializable()
class ArticlesModel {
  final String? categoryName;
  final String? id;
  final String? imageUrlSquare;
  final String? colorCode;
  final String? title;

  ArticlesModel({
    this.categoryName,
    this.id,
    this.imageUrlSquare,
    this.colorCode,
    this.title,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) =>
      _$ArticlesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesModelToJson(this);
}
