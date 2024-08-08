import 'package:flutter/material.dart';

import '../modules/Home/models/trails_model.dart';

class CustomTrailBanner extends StatelessWidget {
  const CustomTrailBanner({
    super.key,
    required this.categories,
  });

  final TrailsModel categories;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        "${categories.imageUrlSquare}",
        fit: BoxFit.cover,
      ),
    );
  }
}
