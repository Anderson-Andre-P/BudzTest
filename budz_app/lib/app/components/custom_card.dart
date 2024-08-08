import 'package:budz_app/app/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Container(
            height: 72.h,
            width: 114.w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: CustomTextBodyTwo(
                    words: title,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                  child: CustomTextSubTitle(
                    words: content,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
