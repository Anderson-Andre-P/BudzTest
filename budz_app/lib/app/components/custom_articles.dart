import 'package:budz_app/app/modules/Home/models/articles_model.dart';
import 'package:flutter/material.dart';

class CustomArticles extends StatelessWidget {
  const CustomArticles({
    super.key,
    required this.articles,
  });

  final ArticlesModel articles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            articles.imageUrlSquare ?? "",
            height: 144.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          articles.title ?? "Sem título",
        ),
      ],
    );
  }
}
