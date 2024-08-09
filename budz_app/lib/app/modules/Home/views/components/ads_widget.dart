import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/ads_model.dart';

class AdsWidget extends StatelessWidget {
  final Future<List<AdsModel>> Function() loadAds;

  const AdsWidget({
    super.key,
    required this.loadAds,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AdsModel>>(
      future: loadAds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Erro ao carregar dados: ${snapshot.error}"),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final banner =
              snapshot.data!.first; // Pega o primeiro (único) item da lista
          return GestureDetector(
            onTap: () {
              Get.toNamed("${banner.link}");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "${banner.imageURL}",
                  height: 136.h,
                  width: 358.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text("Nenhum banner disponível."));
        }
      },
    );
  }
}
