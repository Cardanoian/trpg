import 'package:flutter/material.dart';
import 'package:trpg/widgets/character_card.dart';

import '../models/character.dart';

class HeroWidget extends StatelessWidget {
  final List<Character> heroesList;

  const HeroWidget({
    super.key,
    required this.heroesList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: heroesList.length,
      itemBuilder: (BuildContext context, int index) =>
          CharacterCard(character: heroesList[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
    );
  }
}
