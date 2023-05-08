import 'package:flutter/material.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/widgets/item_card.dart';

Container inventoryWidget({
  required BuildContext context,
  required Character character,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    height: 500,
    width: 400,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("소지금: ${character.gold}M"),
          ),
          ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Item item = character.inventory[index];
                return itemCard(
                  item: item,
                  context: context,
                  character: character,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 5),
              itemCount: character.inventory.length)
        ],
      ),
    ),
  );
}
