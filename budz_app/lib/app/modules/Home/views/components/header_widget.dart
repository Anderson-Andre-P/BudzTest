import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/custom_text.dart';
import '../../controllers/home_controller.dart';

class HeaderWidget extends StatelessWidget {
  final HomeController controller;

  const HeaderWidget(BuildContext context,
      {super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.h,
                          child: Row(
                            children: [
                              CustomTextTitle(words: controller.petName),
                              Icon(
                                controller.petGender == 'male'
                                    ? Icons.male
                                    : Icons.female,
                                color: controller.petGender == 'male'
                                    ? const Color.fromRGBO(107, 223, 242, 1)
                                    : const Color.fromRGBO(255, 105, 180, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 16.h,
                          child: CustomTextBody(words: controller.petBreed),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: Text(
                        'Edit Pet Details',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
