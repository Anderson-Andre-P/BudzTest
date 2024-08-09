import 'package:budz_app/app/components/custom_chip.dart';
import 'package:budz_app/app/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../modules/Home/models/articles_model.dart';

class CustomArticles extends StatelessWidget {
  const CustomArticles({
    super.key,
    required this.articles,
  });

  final ArticlesModel articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (articles.imageUrlSquare != null &&
              articles.imageUrlSquare!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                articles.imageUrlSquare!,
                height: 120.h,
                width: 120.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120.0,
                    width: 99.0,
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            )
          else
            Container(
              height: 120.0,
              width: 120.0,
              color: Colors.grey,
              child: const Icon(Icons.broken_image, size: 50),
            ),
          16.horizontalSpace,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomChip(
                        words: articles.categoryName ?? "Sem título",
                        color: _parseColor(articles.colorCode),
                      ),
                      CustomTextSubTitle(
                        words: articles.title ?? "Sem título",
                        align: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String? hexColor) {
    hexColor = hexColor?.replaceAll("#", "");
    if (hexColor == null || hexColor.isEmpty) {
      return Colors.transparent;
    }
    return Color(int.parse("0xFF$hexColor"));
  }
}
