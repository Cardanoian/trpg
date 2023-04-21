import 'package:flutter/material.dart';

import '../models/character.dart';
import '../widgets/item_card.dart';

class InventoryScreen extends StatefulWidget {
  final Character character;

  const InventoryScreen({
    super.key,
    required this.character,
  });

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.character.name}의 인벤토리"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("돈 : ${widget.character.gold}M"),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ItemCard(
                item: widget.character.inventory[index],
              );
            },
            itemCount: widget.character.inventory.length,
          )
        ],
      ),
    );
  }

  showModal(BuildContext context, String text) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("닫기"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
