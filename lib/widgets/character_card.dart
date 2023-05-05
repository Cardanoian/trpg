import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/skills/skill.dart';
import 'package:trpg/models/targets.dart';
import 'package:trpg/services/save_data.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  final SaveData gameData;

  const CharacterCard({
    super.key,
    required this.character,
    required this.gameData,
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
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected
              ? Colors.blueAccent.withOpacity(0.5)
              : Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                        "Lv ${widget.character.level} ${widget.character.job} ${widget.character.name}"),
                    Text(
                        "체력: ${widget.character.hp} / ${widget.character.maxHp}"),
                    Text(widget.gameData.heroes.contains(widget.character)
                        ? "${widget.character.srcName}: ${widget.character.src} / ${widget.character.maxSrc}"
                        : ""),
                    Text(widget.character.job == "도적"
                        ? "연계: ${widget.character.link} / 4"
                        : ""),
                  ],
                ),
                turnStart(),
                statusButton(),
                inventoryButton(),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.character.skillBook.length,
                itemBuilder: (BuildContext context, int index) {
                  return skillBtn(widget.character.skillBook[index],
                      context.watch<Targets>().items, index);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton turnStart() {
    return ElevatedButton(onPressed: () {}, child: const Text("턴 시작"));
  }

  ElevatedButton inventoryButton() {
    return ElevatedButton(onPressed: () {}, child: const Text("인벤토리"));
  }

  ElevatedButton statusButton() {
    return ElevatedButton(onPressed: () {}, child: const Text("능력치"));
  }

  ElevatedButton skillBtn(Skill skill, List<Character> targets, int index) {
    return ElevatedButton(
      onPressed: () {
        skill.func(targets, widget.character, widget.gameData.heroes,
            widget.gameData.enemies);
        context.read<Targets>().clear();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
            skill.name.length > 5
                ? 120
                : skill.name.length >= 3
                    ? 100
                    : 70,
            50),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            skill.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            skill.src,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> findTopAggro(Character character) {
    Character topChar = character;
    double aggro = 0;
    for (Character char in character.aggro.keys) {
      if (character.aggro[char]! > aggro) {
        aggro = character.aggro[char]!;
        topChar = char;
      }
    }
    return {"character": topChar, "aggro": aggro};
  }

  void provocation(Character me, Character target) {
    double aggro = findTopAggro(target)["aggro"];
    target.aggro[me] = aggro + 1;
    target.renewStat(target);
  }
}
