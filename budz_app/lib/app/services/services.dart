import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

import '../modules/Home/models/ads_model.dart';
import '../modules/Home/models/articles_model.dart';
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

Future<List<AdsModel>> loadAds() async {
  try {
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/budz_home.json');
    final Map<String, dynamic> data = json.decode(response);
    final Map<String, dynamic> singleBannerJson = data['singleBanner'];
    final AdsModel singleBanner = AdsModel.fromJson(singleBannerJson);
    return [singleBanner];
  } catch (e) {
    print("Erro ao carregar JSON: $e");
    rethrow;
  }
}
