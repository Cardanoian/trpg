import 'package:flutter/material.dart';
import 'package:trpg/widgets/character_card.dart';

import '../models/characters/character.dart';

class HeroWidget extends StatelessWidget {
  final List<Character> heroList, enemyList;

  const HeroWidget({
    super.key,
    required this.heroList,
    required this.enemyList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: heroList.length,
      itemBuilder: (BuildContext context, int index) => CharacterCard(
        character: heroList[index],
        heroes: heroList,
        enemies: enemyList,
      ),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
    );
  }
}
