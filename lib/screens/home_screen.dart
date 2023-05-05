import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/screens/main_screen.dart';
import 'package:trpg/screens/new_data_screen.dart';
import 'package:trpg/services/hive_repository.dart';
import 'package:trpg/services/mapToSaveData.dart';
import 'package:trpg/services/save_data.dart';
import 'package:trpg/services/save_data_list.dart';
import 'package:trpg/widgets/save_card.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({
    super.key,
    required this.title,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int index;
  late SaveDataList saveDataList;

  void refresh() {
    for (int i = 0; i < 5; i++) {
      List? mapData = HiveRepository.getData("$i");
      SaveData? data = mapData == null ? null : mapToSaveData(mapData);
      saveDataList.changeSaveData(data, i);
    }
  }

  @override
  Widget build(BuildContext context) {
    saveDataList = context.watch<SaveDataList>();
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
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (saveDataList.saveDataList[index] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(
                                title: widget.title,
                                saveIndex: index,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewDataScreen(
                                title: widget.title,
                                index: index,
                              ),
                            ),
                          );
                        }
                      },
                      child: saveDataList.saveDataList[index] == null
                          ? const NoDataWidget()
                          : SaveCard(
                              index: index,
                              saveDatum: saveDataList.saveDataList[index]!,
                            ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: 5,
                ),
              ],
            ),
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: 300,
        height: 70,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.black54),
        ),
        child: const Text(
          "데이터가 없습니다.",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
