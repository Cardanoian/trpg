// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:trpg/models/characters/character.dart';
// import 'package:trpg/services/save_data.dart';
// import 'package:trpg/widgets/character_card.dart';
//
// class EnemyWidget extends StatelessWidget {
//   const EnemyWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     List<Character> heroList = context.watch<SaveData>().heroes;
//     List<Character> enemyList = context.watch<SaveData>().enemies;
//     return SizedBox(
//       width: 400,
//       child: ListView.separated(
//         itemCount: enemyList.length,
//         itemBuilder: (BuildContext context, int index) => CharacterCard(
//           character: enemyList[index],
//         ),
//         separatorBuilder: (BuildContext context, int index) =>
//             const SizedBox(height: 10),
//       ),
//     );
//   }
// }
