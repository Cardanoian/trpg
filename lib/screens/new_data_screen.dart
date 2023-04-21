import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trpg/models/character.dart';
import 'package:trpg/models/jobs/archer.dart';
import 'package:trpg/models/jobs/paladin.dart';
import 'package:trpg/models/jobs/priest.dart';
import 'package:trpg/models/jobs/rogue.dart';
import 'package:trpg/models/jobs/warrior.dart';
import 'package:trpg/models/jobs/wizard.dart';
import 'package:trpg/services/save_data.dart';

class NewDataScreen extends StatefulWidget {
  final Box box;
  final String title;

  const NewDataScreen({
    Key? key,
    this.title = "TRPG",
    required this.box,
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
  List<Character> heroes = [];

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
    List<SaveData> saveData =
        widget.box.get("saveData", defaultValue: <SaveData>[]);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: "저장",
            onPressed: () {
              if (heroes.isEmpty) return;
              SaveData newData = SaveData(
                  heroes: heroes, enemies: [], lastPlayTime: DateTime.now());
              saveData.add(newData);
              List<Map<String, dynamic>> mapData = [
                for (var data in saveData) dataToBox(data)
              ];
              widget.box.put("saveData", mapData);
              print(
                  "saved length: ${widget.box.get("saveData", defaultValue: <SaveData>[]).length}");
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
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
                  addHeroButton(),
                ],
              ),
              Expanded(child: HeroesListWidget(heroes: heroes)),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton addHeroButton() {
    return ElevatedButton(
      onPressed: () {
        if (heroes.length >= 6) return;
        switch (selectedJob) {
          case "전사":
            heroes.add(
              Warrior(
                name: selectedName,
              ),
            );
            break;
          case "성기사":
            heroes.add(
              Paladin(
                name: selectedName,
              ),
            );
            break;
          case "도적":
            heroes.add(
              Rogue(
                name: selectedName,
              ),
            );
            break;
          case "궁수":
            heroes.add(
              Archer(
                name: selectedName,
              ),
            );
            break;
          case "마법사":
            heroes.add(
              Wizard(
                name: selectedName,
              ),
            );
            break;
          case "사제":
            heroes.add(
              Priest(
                name: selectedName,
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
