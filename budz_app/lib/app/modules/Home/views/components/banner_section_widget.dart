import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_banner.dart';
import '../../models/banner_model.dart';

class BannersSectionWidget extends StatelessWidget {
  final Future<List<BannerModel>> Function() loadBanners;
  final RxInt currentBannerPage;

  const BannersSectionWidget({
    super.key,
    required this.loadBanners,
    required this.currentBannerPage,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: loadBanners(),
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
                  height: 136.h,
                  viewportFraction: 0.8,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    currentBannerPage.value = index;
                  },
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomBanner(banner: snapshot.data![index]),
                  );
                },
              ),
              16.verticalSpace,
              Obx(() => _buildPaginationDots(snapshot.data!.length)),
            ],
          );
        } else {
          return const Center(child: Text("Nenhum banner disponível."));
        }
      },
    );
  }

  Widget _buildPaginationDots(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentBannerPage.value == index ? 18 : 8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: currentBannerPage.value == index ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}
