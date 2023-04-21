import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trpg/screens/main_screen.dart';
import 'package:trpg/screens/new_data_screen.dart';
import 'package:trpg/services/save_data.dart';
import 'package:trpg/widgets/save_card.dart';

class HomeScreen extends StatefulWidget {
  final Box box;
  final String title;

  const HomeScreen({
    super.key,
    this.title = "TRPG",
    required this.box,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> saveData;
  late List<SaveData> gameData;

  void refresh() {
    setState(() {
      print(widget.box.get("saveData", defaultValue: []).runtimeType);
      saveData = widget.box.get("saveData", defaultValue: []);
      print([for (var save in saveData) boxToData(save)].runtimeType);
      gameData = [for (var save in saveData) boxToData(save)];
    });
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    print("length: ${gameData.length}");
    print(gameData.isNotEmpty ? gameData[0].heroes : "Empty");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                refresh();
              },
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newDataButton(context),
              const SizedBox(height: 20),
              saveData.isNotEmpty
                  ? saveDataList(gameData)
                  : const NoDataWidget(),
            ],
          ),
        ),
      ),
    );
  }

  ListView saveDataList(List<SaveData> gameData) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => gameData[index],
                  child: MainScreen(
                    title: widget.title,
                  ),
                ),
              ),
            );
          },
          child: SaveCard(saveDatum: gameData[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
      itemCount: saveData.length,
    );
  }

  ElevatedButton newDataButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewDataScreen(
              box: widget.box,
              title: widget.title,
            ),
          ),
        );
      },
      child: const Text(
        "새 데이터",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.blueAccent),
      ),
      child: const Text(
        "데이터가 없습니다.",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      ),
    );
  }
}
