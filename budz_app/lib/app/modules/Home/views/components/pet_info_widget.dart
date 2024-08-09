import 'package:flutter/material.dart';

import '../../../../components/custom_card.dart';

class PetInfoWidget extends StatelessWidget {
  const PetInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomCard(title: "Sexo", content: "Male"),
        CustomCard(title: "Idade", content: "1a 3m"),
        CustomCard(title: "Peso", content: "--"),
      ],
    );
  }
}
