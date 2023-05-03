import 'package:flutter/material.dart';

import '../models/characters/character.dart';
import 'character_card.dart';

class EnemyWidget extends StatelessWidget {
  final List<Character> heroList, enemyList;

  const EnemyWidget({
    super.key,
    required this.enemyList,
    required this.heroList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: enemyList.length,
      itemBuilder: (BuildContext context, int index) => CharacterCard(
        character: enemyList[index],
        heroes: heroList,
        enemies: enemyList,
      ),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
    );
  }
}
