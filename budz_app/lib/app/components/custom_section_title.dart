import 'package:budz_app/app/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSectionTitle extends StatelessWidget {
  const CustomSectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextTitle(words: title),
                CustomTextBody(words: subtitle),
              ],
            ),
            Row(
              children: [
                TextButton(
                  child: Text(
                    "Ver tudo",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2.sp,
                      fontFamily: "Outfit",
                      color: const Color.fromRGBO(35, 113, 238, 1),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  onPressed: () {},
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color.fromRGBO(35, 113, 238, 1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
