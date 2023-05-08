import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/screens/game_screen_widget.dart';
import 'package:trpg/screens/new_data_screen.dart';
import 'package:trpg/services/game_data.dart';
import 'package:trpg/services/save_data_list.dart';
import 'package:trpg/widgets/no_data_widget.dart';
import 'package:trpg/widgets/save_card.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  context.read<GameData>().updatePlayIndex(index);
                  if (context.watch<SaveDataList>().saveDataList[index] !=
                      null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreenWidget(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewDataScreen(),
                      ),
                    );
                  }
                },
                child: context.watch<SaveDataList>().saveDataList[index] == null
                    ? const NoDataWidget()
                    : SaveCard(
                        index: index,
                      ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
