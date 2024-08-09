import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_trail_banner.dart';
import '../../models/trails_model.dart';

class TrailSectionWidget extends StatelessWidget {
  final Future<List<TrailsModel>> Function() loadTrailBanners;
  final RxInt currentTrailPage;

  const TrailSectionWidget({
    super.key,
    required this.loadTrailBanners,
    required this.currentTrailPage,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrailsModel>>(
      future: loadTrailBanners(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Erro ao carregar dados: ${snapshot.error}"),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 174.h,
                  viewportFraction: 0.3,
                  enlargeCenterPage: false,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    currentTrailPage.value = index;
                  },
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTrailBanner(categories: snapshot.data![index]),
                  );
                },
              ),
              Obx(() => _buildPaginationDots(snapshot.data!.length)),
            ],
          );
        } else {
          return const Center(child: Text("Nenhum treinamento disponível."));
        }
      },
    );
  }

  Widget _buildPaginationDots(int itemCount) {
    return Column(
      children: [
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            itemCount,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: currentTrailPage.value == index ? 18 : 8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                color:
                    currentTrailPage.value == index ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
