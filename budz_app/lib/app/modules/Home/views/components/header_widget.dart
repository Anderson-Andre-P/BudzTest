import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/constants.dart';
import '../../../../components/custom_text.dart';

class HeaderWidget extends StatelessWidget {
  final String petPhotoUrl;
  final String petName;
  final String petGender;
  final String petBreed;

  const HeaderWidget({
    super.key,
    required this.petPhotoUrl,
    required this.petName,
    required this.petGender,
    required this.petBreed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          petPhotoUrl.isNotEmpty
              ? petPhotoUrl
              : 'https://via.placeholder.com/80',
          width: 80.w,
          height: 80.h,
          fit: BoxFit.cover,
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextTitle(words: petName),
                Icon(
                  petGender == 'male' ? Icons.male : Icons.female,
                  color: petGender == 'male'
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
            4.verticalSpace,
            CustomTextBody(words: petBreed),
          ],
        ),
        const Spacer(),
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
                24.verticalSpace,
                Row(
                  children: [
                    Image.network(
                      petPhotoUrl.isNotEmpty
                          ? petPhotoUrl
                          : 'https://via.placeholder.com/80',
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                    12.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.h,
                          child: Row(
                            children: [
                              CustomTextTitle(words: petName),
                              Icon(
                                petGender == 'male' ? Icons.male : Icons.female,
                                color: petGender == 'male'
                                    ? const Color.fromRGBO(107, 223, 242, 1)
                                    : const Color.fromRGBO(255, 105, 180, 1),
                              ),
                            ],
                          ),
                        ),
                        4.verticalSpace,
                        SizedBox(
                          height: 18.h,
                          child: CustomTextBody(words: petBreed),
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
                24.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
