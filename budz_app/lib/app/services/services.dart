// lib/app/modules/Home/services/services.dart

import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

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
