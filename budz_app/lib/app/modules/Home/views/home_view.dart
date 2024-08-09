import 'package:budz_app/app/components/custom_articles.dart';
import 'package:budz_app/app/modules/Home/models/articles_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_banner.dart';
import '../../../components/custom_card.dart';
import '../../../components/custom_section_title.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_trail_banner.dart';
import '../../../services/services.dart';
import '../controllers/home_controller.dart';
import '../models/banner_model.dart';
import '../models/trails_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
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
                    return Center(
                      child: Text("Erro ao carregar dados: ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final banners = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 136.h,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              controller.currentBannerPage.value = index;
                            },
                          ),
                          itemCount: banners.length,
                          itemBuilder: (context, index, realIndex) {
                            final banner = banners[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CustomBanner(banner: banner),
                            );
                          },
                        ),
                        16.verticalSpace,
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              banners.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                height: 8,
                                width:
                                    controller.currentBannerPage.value == index
                                        ? 18
                                        : 8,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  color: controller.currentBannerPage.value ==
                                          index
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
              ),
              16.verticalSpace,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomSectionTitle(
                  title: "Explorar Jornadas",
                  subtitle: "Descubra novas trilhas",
                ),
              ),
              FutureBuilder<List<TrailsModel>>(
                future: loadTrailBanners(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Erro ao carregar dados: ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final categories = snapshot.data!;
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 144.h,
                        viewportFraction: 0.3,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        onPageChanged: (index, reason) {
                          controller.currentTrailPage.value = index;
                        },
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index, realIndex) {
                        final category = categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomTrailBanner(categories: category),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Nenhum treinamento disponível.",
                      ),
                    );
                  }
                },
              ),
              16.verticalSpace,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomSectionTitle(
                  title: "Artigos",
                  subtitle: "Conteúdos e dicas extras",
                ),
              ),
              FutureBuilder<List<ArticlesModel>>(
                future: loadArticles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Erro ao carregar dados: ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final articles = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap:
                          true, // Permite que a ListView use apenas o espaço necessário
                      physics:
                          const NeverScrollableScrollPhysics(), // Desativa o scroll da ListView para que o SingleChildScrollView controle o scroll
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CustomArticles(articles: article),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Nenhum artigo disponível.",
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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
