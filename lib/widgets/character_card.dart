import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/skills/skill.dart';
import 'package:trpg/models/targets.dart';
import 'package:trpg/services/game_data.dart';
import 'package:trpg/services/save_data.dart';
import 'package:trpg/services/save_data_list.dart';
import 'package:trpg/widgets/inventory_widget.dart';
import 'package:trpg/widgets/status_card.dart';

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
  bool isSelected = false;
  late SaveData gameData;

  @override
  Widget build(BuildContext context) {
    gameData = context
        .watch<SaveDataList>()
        .saveDataList[context.watch<GameData>().playIndex]!;
    return GestureDetector(
      onTap: () {
        isSelected = !isSelected;
        if (isSelected) {
          context.read<Targets>().add(widget.character);
        } else {
          context.read<Targets>().remove(widget.character);
        }
        print(context.watch<Targets>().items);
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
                  children: characterDescribe(widget.character),
                ),
                effectsGridView(),
                turnStart(widget.character, context),
                statusButton(context, widget.character),
                inventoryButton(context, widget.character),
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

  GridView effectsGridView() {
    return GridView.builder(
      itemCount: widget.character.effects.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Effect effect = widget.character.effects[index];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(effect.toString()),
                elevation: 5.0,
                showCloseIcon: true,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: widget.character.effects[index].image,
        );
      },
    );
  }

  List<Widget> characterDescribe(Character character) {
    return [
      Text("Lv ${character.level} ${character.job} ${character.name}"),
      Text("체력: ${character.hp} / ${character.maxHp}"),
      Text(gameData.heroes.contains(character)
          ? "${character.srcName}: ${character.src} / ${character.maxSrc}"
          : ""),
      character.job == "도적"
          ? Text("연계: ${character.link} / 4")
          : character.job == "마법사"
              ? Text(
                  "주문강화: ${character.tripleDamage ? "🟢" : "⭕"} 속성: ${character.lastSource}")
              : const SizedBox()
    ];
  }

  ElevatedButton turnStart(Character me, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          for (var character in (me.heroes + me.enemies)) {
            character.turnOff();
          }
          me.turnStart();
        },
        child: const Text("턴 시작"));
  }

  ElevatedButton inventoryButton(BuildContext context, Character me) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              barrierLabel: "${me.name}의 인벤토리",
              context: context,
              builder: (BuildContext context) {
                return inventoryWidget(context: context, character: me);
              });
        },
        child: const Text("인벤토리"));
  }

  ElevatedButton statusButton(BuildContext context, Character me) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              barrierLabel: "${me.name}의 능력치",
              context: context,
              builder: (BuildContext context) {
                return StatusCard(character: me);
              });
        },
        child: const Text("능력치"));
  }

  ElevatedButton skillBtn(Skill skill, List<Character> targets, int index) {
    return ElevatedButton(
      onPressed: () {
        skill.func(targets, widget.character);

        //
        //
        // Todo Write to Analysis
        //
        //

        for (var target in targets) {
          if (target.hp <= 0) {
            context.read<GameData>().changeBattlePoint(target.level, target.hp);
          }
        }
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
    target.refreshStatus();
  }
}
