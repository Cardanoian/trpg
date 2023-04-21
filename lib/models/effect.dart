class Effect {
  String? by;
  String name;
  int duration;
  double strength;
  double dex, intel, hp, atBonus, combat, dfBonus, diceAdv;

  Effect(
      {this.by = "tmp",
      this.name = "tmp",
      this.duration = 0,
      this.strength = 0,
      this.dex = 0,
      this.intel = 0,
      this.hp = 0,
      this.atBonus = 0,
      this.combat = 0,
      this.dfBonus = 0,
      this.diceAdv = 0});
}

class Buff extends Effect {
  String type = "buff";

  Buff(
      {String by = "tmp",
      String name = "tmp",
      int duration = 0,
      double strength = 0,
      double dex = 0,
      double intel = 0,
      double hp = 0,
      double atBonus = 0,
      double combat = 0,
      double dfBonus = 0,
      double diceAdv = 0})
      : super(
            by: by,
            name: name,
            duration: duration,
            strength: strength,
            dex: dex,
            intel: intel,
            hp: hp,
            atBonus: atBonus,
            combat: combat,
            dfBonus: dfBonus,
            diceAdv: diceAdv);
}

class Debuff extends Effect {
  String type = "debuff";

  Debuff(
      {String by = "tmp",
      String name = "tmp",
      int duration = 0,
      double strength = 0,
      double dex = 0,
      double intel = 0,
      double hp = 0,
      double atBonus = 0,
      double combat = 0,
      double dfBonus = 0,
      double diceAdv = 0})
      : super(
            by: by,
            name: name,
            duration: duration,
            strength: strength,
            dex: dex,
            intel: intel,
            hp: hp,
            atBonus: atBonus,
            combat: combat,
            dfBonus: dfBonus,
            diceAdv: diceAdv);
}
