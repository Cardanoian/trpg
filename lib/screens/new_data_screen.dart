import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/characters/jobs/archer.dart';
import 'package:trpg/models/characters/jobs/paladin.dart';
import 'package:trpg/models/characters/jobs/priest.dart';
import 'package:trpg/models/characters/jobs/rogue.dart';
import 'package:trpg/models/characters/jobs/warrior.dart';
import 'package:trpg/models/characters/jobs/wizard.dart';
import 'package:trpg/services/game_data.dart';
import 'package:trpg/services/hive_repository.dart';
import 'package:trpg/services/saveDataToMap.dart';
import 'package:trpg/services/save_data.dart';
import 'package:trpg/services/save_data_list.dart';

class NewDataScreen extends StatefulWidget {
  const NewDataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NewDataScreen> createState() => _NewDataScreenState();
}

class _NewDataScreenState extends State<NewDataScreen> {
  TextEditingController nameController = TextEditingController();
  final List<String> jobList = [
    "선택",
    "전사",
    "성기사",
    "도적",
    "궁수",
    "마법사",
    "사제",
  ];

  String selectedName = "";
  String selectedJob = "선택";

  // List<Character> heroes = [];
  SaveData newData = SaveData(
    heroes: <Character>[],
    enemies: <Character>[],
    lastPlayTime: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      selectedName = nameController.text;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<GameData>().title),
        actions: [
          IconButton(
            tooltip: "저장",
            onPressed: () {
              if (newData.heroes.isEmpty) return;
              print([
                for (var hero in newData.heroes)
                  [
                    hero.name,
                    hero.job,
                  ]
              ]);
              print([for (var hero in newData.heroes) hero.runtimeType]);
              newData.resetPlayTime();
              for (var hero in newData.heroes) {
                hero.hp = hero.maxHp;
                hero.src = hero.maxSrc;
              }
              HiveRepository.put("${context.watch<GameData>().playIndex}",
                  saveDataToMap(newData));
              context
                  .read<SaveDataList>()
                  .changeSaveData(newData, context.watch<GameData>().playIndex);
            },
            icon: const Icon(Icons.save_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NameInputWidget(nameController: nameController),
                const SizedBox(height: 10),
                jobSelectingWidget(),
                const SizedBox(height: 10),
                addHeroButton(context),
              ],
            ),
            Expanded(child: HeroesListWidget(heroes: newData.heroes)),
          ],
        ),
      ),
    );
  }

  ElevatedButton addHeroButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (newData.heroes.length > 5) return;
        switch (selectedJob) {
          case "전사":
            newData.addHero(
              warrior(
                selectedName,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .heroes,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .enemies,
              ),
            );
            break;
          case "성기사":
            newData.addHero(
              paladin(
                selectedName,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .heroes,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .enemies,
              ),
            );
            break;
          case "도적":
            newData.addHero(
              rogue(
                selectedName,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .heroes,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .enemies,
              ),
            );
            break;
          case "궁수":
            newData.addHero(
              archer(
                selectedName,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .heroes,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .enemies,
              ),
            );
            break;
          case "마법사":
            newData.addHero(
              wizard(
                selectedName,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .heroes,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .enemies,
              ),
            );
            break;
          case "사제":
            newData.addHero(
              priest(
                selectedName,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .heroes,
                context
                    .watch<SaveDataList>()
                    .saveDataList[context.watch<GameData>().playIndex]!
                    .enemies,
              ),
            );
            break;
          default:
            break;
        }
        setState(() {
          nameController.text = "";
          selectedJob = "선택";
        });
      },
      child: const Text("캐릭터 추가"),
    );
  }

  Row jobSelectingWidget() {
    return Row(
      children: [
        const Text("직업 : "),
        DropdownButton<String>(
          value: selectedJob,
          items: jobList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedJob = value!;
            });
          },
        ),
      ],
    );
  }
}

class HeroesListWidget extends StatelessWidget {
  const HeroesListWidget({
    super.key,
    required this.heroes,
  });

  final List<Character> heroes;

  @override
  Widget build(BuildContext context) {
    return heroes.isEmpty
        ? const SizedBox(height: 100, width: 100)
        : ListView.separated(
            itemCount: heroes.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 10,
                child: ListTile(
                  title: Center(
                    child: Text(
                      heroes[index].name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      heroes[index].job,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
          );
  }
}

class NameInputWidget extends StatelessWidget {
  const NameInputWidget({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("이름 : "),
        SizedBox(
          width: 200,
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "이름",
              labelStyle: const TextStyle(color: Colors.blueAccent),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.blueAccent, width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[600]!, width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}
