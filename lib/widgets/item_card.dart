import 'package:flutter/material.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/item.dart';

Container itemCard({
  required Item item,
  required BuildContext context,
  required Character character,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: BorderRadius.circular(5),
      color: itemColor(item),
    ),
    width: 350,
    child: Column(
      children: [
        Text(item.toString()),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent.withOpacity(0.8),
            foregroundColor: Colors.deepPurple.withOpacity(0.8),
            elevation: 5,
          ),
          onPressed: () {
            character.wearItem(item);
          },
          child: const Text(
            "착용",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
