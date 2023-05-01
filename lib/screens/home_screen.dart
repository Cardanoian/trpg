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
  late int index;
  late List<SaveData?> saveDataList;

  void refresh() {
    setState(() {
      saveDataList = [];
      int i = 0;
      for (int i = 0; i < 5; i++) {
        SaveData? data = widget.box.get("$i");
        saveDataList.add(data);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    print(
        "length: ${saveDataList.map((element) => element != null ? 1 : 0).reduce((value, element) => value + element)}");
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "데이터 불러오기",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                saveDataListView(saveDataList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView saveDataListView(List<SaveData?> gameData) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (gameData[index] != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (BuildContext context) => gameData[index],
                    child: MainScreen(
                      title: widget.title,
                      box: widget.box,
                      gameData: gameData[index]!,
                    ),
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewDataScreen(
                    box: widget.box,
                    title: widget.title,
                    index: index,
                  ),
                ),
              );
            }
          },
          child: gameData[index] == null
              ? const NoDataWidget()
              : SaveCard(
                  box: widget.box,
                  index: index,
                  saveDatum: gameData[index]!,
                ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
      itemCount: 5,
    );
  }

// ElevatedButton newDataButton(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => NewDataScreen(
//             box: widget.box,
//             title: widget.title,
//           ),
//         ),
//       );
//     },
//     child: const Text(
//       "새 데이터",
//       style: TextStyle(
//         fontSize: 30,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//   );
// }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.blueAccent),
        ),
        child: const Text(
          "데이터가 없습니다.",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
