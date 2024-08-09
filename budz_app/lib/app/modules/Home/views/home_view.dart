import 'package:budz_app/app/components/custom_section_title.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/custom_articles.dart';
import '../../../components/custom_banner.dart';
import '../../../components/custom_card.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_trail_banner.dart';
import '../../../services/services.dart';
import '../controllers/home_controller.dart';
import '../models/articles_model.dart';
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
              _buildHeader(context),
              SizedBox(height: 24.h),
              _buildPetInfo(),
              16.verticalSpace,
              _buildBannersSection(),
              16.verticalSpace,
              const CustomSectionTitle(title: "title", subtitle: "subtitle"),
              _buildTrailSection(),
              const CustomSectionTitle(title: "title", subtitle: "subtitle"),
              16.verticalSpace,
              _buildArticlesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Image.network(
          controller.petPhotoUrl.isNotEmpty
              ? controller.petPhotoUrl
              : 'https://via.placeholder.com/80',
          width: 80.w,
          height: 80.h,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextTitle(words: controller.petName),
                Icon(
                  controller.petGender == 'male' ? Icons.male : Icons.female,
                  color: controller.petGender == 'male'
                      ? const Color.fromRGBO(107, 223, 242, 1)
                      : const Color.fromRGBO(255, 105, 180, 1),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => _showEditBottomSheet(context),
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ],
            ),
            const SizedBox(height: 4),
            CustomTextBody(words: controller.petBreed),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit_outlined),
        )
      ],
    );
  }

  Widget _buildPetInfo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomCard(title: "Sexo", content: "Male"),
        CustomCard(title: "Idade", content: "1a 3m"),
        CustomCard(title: "Peso", content: "--"),
      ],
    );
  }

  Widget _buildBannersSection() {
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
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    controller.currentBannerPage.value = index;
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
              _buildPaginationDots(snapshot.data!.length),
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
          width: controller.currentBannerPage.value == index ? 18 : 8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: controller.currentBannerPage.value == index
                ? Colors.blue
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildTrailSection() {
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTrailBanner(categories: snapshot.data![index]),
              );
            },
          );
        } else {
          return const Center(child: Text("Nenhum treinamento disponível."));
        }
      },
    );
  }

  Widget _buildArticlesSection() {
    return FutureBuilder<List<ArticlesModel>>(
      future: loadArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Erro ao carregar dados: ${snapshot.error}"),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final article = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomArticles(articles: article),
              );
            },
          );
        } else {
          return const Center(child: Text("Nenhum artigo disponível."));
        }
      },
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
                    Image.network(
                      controller.petPhotoUrl.isNotEmpty
                          ? controller.petPhotoUrl
                          : 'https://via.placeholder.com/80',
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextTitle(
                            words: controller.petName,
                          ),
                          CustomTextBody(
                            words: controller.petBreed,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Lógica para editar o pet ou selecionar outro pet
                      },
                      icon: const Icon(Icons.edit_outlined),
                    )
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Fechar'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
