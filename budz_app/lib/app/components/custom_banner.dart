import 'package:budz_app/app/modules/Home/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.banner,
  });

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!await launchUrl(Uri.parse("${banner.link}"))) {
          throw Exception('Could not launch ${banner.link}');
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          "${banner.imageURL}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
