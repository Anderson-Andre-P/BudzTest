import 'package:budz_app/app/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../modules/Home/models/trails_model.dart';

class CustomTrailBanner extends StatelessWidget {
  const CustomTrailBanner({
    super.key,
    required this.categories,
  });

  final TrailsModel categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "${categories.imageUrlSquare}",
            fit: BoxFit.cover,
          ),
        ),
        8.verticalSpace,
        CustomTextSubTitle(
          words: "${categories.name}",
        ),
      ],
    );
  }
}
