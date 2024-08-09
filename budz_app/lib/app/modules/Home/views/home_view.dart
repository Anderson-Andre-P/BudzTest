import 'package:budz_app/app/components/custom_section_title.dart';
import 'package:budz_app/app/modules/Home/views/components/header_widget.dart';
import 'package:budz_app/app/modules/Home/views/components/pet_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/services.dart';
import '../controllers/home_controller.dart';
import 'components/ads_widget.dart';
import 'components/articles_section_widget.dart';
import 'components/banner_section_widget.dart';
import 'components/trail_section_widget.dart';

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

            // Extraindo dados do pet
            final petData = data['pet'];
            final petPhotoUrl = petData['photoUrl'] ?? '';
            final petName = petData['name'] ?? '';
            final petGender = petData['gender'] ?? '';
            final petBreed = petData['breed'] ?? '';

            return _buildContent(
              context,
              petPhotoUrl: petPhotoUrl,
              petName: petName,
              petGender: petGender,
              petBreed: petBreed,
            );
          } else {
            return const Center(child: Text("Nenhum dado disponível."));
          }
        }
      },
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required String petPhotoUrl,
    required String petName,
    required String petGender,
    required String petBreed,
  }) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              16.verticalSpace,
              HeaderWidget(
                petPhotoUrl: petPhotoUrl,
                petName: petName,
                petGender: petGender,
                petBreed: petBreed,
              ),
              16.verticalSpace,
              const PetInfoWidget(),
              16.verticalSpace,
              BannersSectionWidget(
                loadBanners: loadBanners,
                currentBannerPage: controller.currentBannerPage,
              ),
              16.verticalSpace,
              const CustomSectionTitle(
                  title: "Explorar Jornadas",
                  subtitle: "Descubra novas trilhas"),
              16.verticalSpace,
              TrailSectionWidget(
                loadTrailBanners: loadTrailBanners,
                currentTrailPage: controller.currentTrailPage,
              ),
              16.verticalSpace,
              const AdsWidget(
                loadAds: loadAds,
              ),
              16.verticalSpace,
              const CustomSectionTitle(
                  title: "Artigos", subtitle: "Conteúdos e dicas extras"),
              16.verticalSpace,
              const ArticlesSectionWidget(
                loadArticles: loadArticles,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
