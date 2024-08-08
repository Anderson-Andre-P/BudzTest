import 'package:budz_app/app/components/custom_card.dart';
import 'package:budz_app/app/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_banner.dart';
import '../../../services/services.dart';
import '../controllers/home_controller.dart';
import '../models/banner_model.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJsonData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar dados."));
        } else {
          if (snapshot.hasData) {
            final data = snapshot.data as Map<String, dynamic>;
            controller.loadPetData(data);
          }
          return _buildContent(context);
        }
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            16.verticalSpace,
            Row(
              children: [
                Obx(() => Image.network(
                      controller.petPhotoUrl.value.isNotEmpty
                          ? controller.petPhotoUrl.value
                          : 'https://via.placeholder.com/80',
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(() => CustomTextTitle(
                              words: controller.petName.value,
                            )),
                        Obx(() => Icon(
                              controller.petGender.value == 'male'
                                  ? Icons.male
                                  : Icons.female,
                              color: controller.petGender.value == 'male'
                                  ? const Color.fromRGBO(107, 223, 242, 1)
                                  : const Color.fromRGBO(255, 105, 180, 1),
                            )),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            _showEditBottomSheet(context);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Obx(() => CustomTextBody(
                          words: controller.petBreed.value,
                        )),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(title: "Sexo", content: "Male"),
                CustomCard(title: "Idade", content: "1a 3m"),
                CustomCard(title: "Peso", content: "--"),
              ],
            ),
            16.verticalSpace,
            FutureBuilder<List<BannerModel>>(
              future: loadBanners(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print("Erro ao carregar dados: ${snapshot.error}");
                  return Center(
                    child: Text("Erro ao carregar dados: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final banners = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 136,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: PageController(
                            viewportFraction: 0.85,
                          ),
                          itemCount: banners.length,
                          itemBuilder: (context, index) {
                            final banner = banners[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                left: 0,
                                bottom: 0,
                                top: 16,
                              ),
                              child: CustomBanner(banner: banner),
                            );
                          },
                          onPageChanged: (index) {
                            _currentPage.value = index;
                          },
                        ),
                      ),
                      16.verticalSpace,
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            banners.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: _currentPage.value == index ? 18 : 8,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                color: _currentPage.value == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Nenhum banner disponível.",
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  final RxInt _currentPage = 0.obs;

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 180.h,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Color.fromRGBO(0, 0, 0, 0.85),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Obx(() => Image.network(
                          controller.petPhotoUrl.value.isNotEmpty
                              ? controller.petPhotoUrl.value
                              : 'https://via.placeholder.com/80',
                          width: 60.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.h,
                          child: Row(
                            children: [
                              Obx(() => CustomTextTitle(
                                    words: controller.petName.value,
                                  )),
                              Obx(() => Icon(
                                    controller.petGender.value == 'male'
                                        ? Icons.male
                                        : Icons.female,
                                    color: controller.petGender.value == 'male'
                                        ? const Color.fromRGBO(107, 223, 242, 1)
                                        : const Color.fromRGBO(
                                            255, 105, 180, 1),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => SizedBox(
                            height: 24.h,
                            child: CustomTextSubTitle(
                              words: controller.petBreed.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: true,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {},
                    )
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.amber,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Colors.amber[50],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Constants.crown,
                        colorFilter: const ColorFilter.mode(
                          Colors.amber,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Text("Adicione mais pets com Budz Premium."),
                      const Icon(
                        Icons.arrow_forward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
