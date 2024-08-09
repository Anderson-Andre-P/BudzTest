import 'dart:convert';

import 'package:budz_app/app/modules/Home/models/articles_model.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../modules/Home/models/banner_model.dart';
import '../modules/Home/models/trails_model.dart';

Future<Map<String, dynamic>> loadJsonData() async {
  try {
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/budz_home.json');
    final data = json.decode(response);
    return data;
  } catch (e) {
    print("Erro ao carregar JSON: $e");
    rethrow;
  }
}

Future<List<BannerModel>> loadBanners() async {
  try {
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/budz_home.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> bannersJson = data['banners'];
    return bannersJson.map((json) => BannerModel.fromJson(json)).toList();
  } catch (e) {
    print("Erro ao carregar JSON: $e");
    rethrow;
  }
}

Future<List<TrailsModel>> loadTrailBanners() async {
  try {
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/budz_home.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> categoriesJson = data['categories'];
    return categoriesJson.map((json) => TrailsModel.fromJson(json)).toList();
  } catch (e) {
    print("Erro ao carregar JSON: $e");
    rethrow;
  }
}

Future<List<ArticlesModel>> loadArticles() async {
  try {
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/budz_home.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> articlesJson = data['articles'];
    return articlesJson.map((json) => ArticlesModel.fromJson(json)).toList();
  } catch (e) {
    print("Erro ao carregar JSON: $e");
    rethrow;
  }
}
