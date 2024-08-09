import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    var theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constants.logoPNG,
                width: 90.w,
                height: 90.h,
              ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 500),
                  begin: 1,
                  curve: Curves.easeInSine),
              20.verticalSpace,
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Budz',
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: Colors.blue.shade700,
                    ),
                  ),
                  TextSpan(
                    text: 'App',
                    style: theme.textTheme.displaySmall,
                  ),
                ]),
              ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 500),
                  begin: 5,
                  curve: Curves.easeInSine),
            ],
          ),
        ),
      ),
    );
  }
}
