import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/skill.dart';

import '../models/characters/character.dart';
import '../models/targets.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  final List<Character> heroes, enemies;

  const CharacterCard({
    super.key,
    required this.character,
    required this.heroes,
    required this.enemies,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          if (isSelected) {
            context.read<Targets>().add(widget.character);
          } else {
            context.read<Targets>().remove(widget.character);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected
              ? Colors.blueAccent.withOpacity(0.5)
              : Colors.grey[200],
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
                Text(widget.heroes.contains(widget.character)
                    ? "${widget.character.srcName}: ${widget.character.src}} / 100"
                    : ""),
              ],
            ),
            Column(
              children: [
                for (int i = 0; i < 5; i++)
                  widget.character.skillBook[i].name == ""
                      ? ElevatedButton(
                          onPressed: () {},
                          child: const Text("없음"),
                        )
                      : skillBtn(
                          widget.character.skillBook[i],
                          context.watch<List<Character>>(),
                          i,
                        ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> findTopAggro(Character character) {
    String name = "";
    double aggro = 0;
    for (Character char in character.aggro.keys) {
      if (character.aggro[char]! > aggro) {
        aggro = character.aggro[char]!;
        name = char.name;
      }
    }
    return {"name": name, "aggro": aggro};
  }

  ElevatedButton skillBtn(Skill skill, List<Character> targets, int index) {
    return ElevatedButton(
        onPressed: () {
          if ((widget.character.job == "전사" || widget.character.job == "성기사") &&
              index == 6) {
            provocation(widget.character, targets[0]);
          } else if (widget.character.job == "사제" && index == 2) {
            widget.character.skillBook[index].func(
              targets,
              widget.character,
              widget.heroes,
            );
          } else {
            widget.character.skillBook[index].func(
              targets,
              widget.character,
            );
          }
          context.read<Targets>().clear();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(50, 10),
        ),
        child: Text(index == 6 ? "도발" : skill.name));
  }

  void provocation(Character me, Character target) {
    double aggro = findTopAggro(target)["aggro"];
    target.aggro[me] = aggro + 10;
    target.renewStat(target);
  }
}
