import 'package:flutter/material.dart';

import '../../../../components/custom_articles.dart';
import '../../models/articles_model.dart';

class ArticlesSectionWidget extends StatelessWidget {
  final Future<List<ArticlesModel>> Function() loadArticles;

  const ArticlesSectionWidget({super.key, required this.loadArticles});

  @override
  Widget build(BuildContext context) {
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
}
