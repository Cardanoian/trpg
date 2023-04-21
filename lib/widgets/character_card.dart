import 'package:flutter/material.dart';
import 'package:trpg/models/skill.dart';

import '../models/character.dart';

class CharacterCard extends StatefulWidget {
  final Character character;

  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/character.png"),
          Column(
            children: [
              Row(
                children: [
                  Text("이름: ${widget.character.name}"),
                  Text("레벨: ${widget.character.level}"),
                ],
              ),
              Text("체력: ${widget.character.hp} / ${widget.character.maxHp}"),
              Text(
                  "${widget.character.srcName}: ${widget.character.src}} / 100"),
            ],
          ),
          Column(
            children: [
              skillBtn(widget.character.skillBook.skill1),
              skillBtn(widget.character.skillBook.skill2),
              skillBtn(widget.character.skillBook.skill3),
              skillBtn(widget.character.skillBook.skill4),
              skillBtn(widget.character.skillBook.skill5),
            ],
          ),
        ],
      ),
    );
  }
}

ElevatedButton skillBtn(Skill skill) {
  return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(50, 10),
      ),
      child: Text(skill.name));
}
