import 'package:flutter/material.dart';

import '../models/character.dart';
import 'character_card.dart';

class EnemyWidget extends StatelessWidget {
  final List<Character> enemyList;

  const EnemyWidget({
    super.key,
    required this.enemyList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: enemyList.length,
      itemBuilder: (BuildContext context, int index) =>
          CharacterCard(character: enemyList[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
    );
  }
}
