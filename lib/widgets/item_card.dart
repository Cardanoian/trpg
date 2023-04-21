import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemCard extends StatefulWidget {
  final Item item;

  const ItemCard({
    super.key,
    required this.item,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/item.png"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("이름: ${widget.item.name}"),
                Text("타입: ${widget.item.itemType}"),
                Text("가격: ${widget.item.cost}"),
                Text("수량: ${widget.item.quantity}"),
              ],
            ),
            Row(
              children: [
                Text(
                    "등급: ${widget.item.grade == Grade.normal ? "일반급" : widget.item.grade == Grade.uncommon ? "희귀급" : widget.item.grade == Grade.heroic ? "영웅급" : widget.item.grade == Grade.legendary ? "전설급" : "마왕급"}"),
                Text("공격력: ${widget.item.atBonus}"),
                Text("방어력: ${widget.item.dfBonus}"),
                Text("전투력: ${widget.item.combat}"),
              ],
            ),
            Row(
              children: [
                Text("힘: ${widget.item.strength}"),
                Text("민첩: ${widget.item.dex}"),
                Text("지능: ${widget.item.intel}"),
                Text("주사위 보너스: ${widget.item.diceAdv}"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
