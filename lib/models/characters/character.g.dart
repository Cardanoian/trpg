// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 102;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      job: fields[2] as String,
      lvS: fields[6] as double,
      lvD: fields[7] as double,
      lvI: fields[8] as double,
      src: fields[9] as double,
      maxSrc: fields[10] as double,
      bStr: fields[3] as double,
      bDex: fields[4] as double,
      bInt: fields[5] as double,
      level: fields[17] as int,
      exp: fields[11] as double,
      diceAdv: fields[12] as double,
      weaponType: fields[19] as Type,
      armorType: fields[20] as Type,
      hero: fields[32] as bool,
      isAlive: fields[33] as bool,
      name: fields[0] as String,
      srcName: fields[1] as String,
      levelUp: fields[42] as Function,
      battleStart: fields[43] as Function,
      turnStart: fields[44] as Function,
      getDamage: fields[45] as Function,
      getHp: fields[46] as Function,
      itemStats: (fields[28] as List).cast<String>(),
      weapon: fields[29] as Item,
      armor: fields[30] as Item,
      accessory: fields[31] as Item,
      skillBook: (fields[18] as List).cast<Skill>(),
      heroes: (fields[47] as List).cast<Character>(),
      enemies: (fields[48] as List).cast<Character>(),
    )
      ..atBonus = fields[13] as double
      ..dfBonus = fields[14] as double
      ..combat = fields[15] as double
      ..gold = fields[16] as double
      ..cStr = fields[21] as double
      ..cDex = fields[22] as double
      ..cInt = fields[23] as double
      ..maxHp = fields[24] as double
      ..hp = fields[25] as double
      ..effects = (fields[26] as List).cast<Effect>()
      ..inventory = (fields[27] as List).cast<Item>()
      ..skillCools = (fields[34] as List).cast<dynamic>()
      ..blowAvailable = fields[35] as double
      ..link = fields[36] as int
      ..lastTarget = fields[37] as Character?
      ..aggro = (fields[38] as Map).cast<Character, double>()
      ..barrier = fields[39] as double
      ..tripleDamage = fields[40] as bool
      ..lastSource = fields[41] as String
      ..timePoint = fields[49] as double;
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(50)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.srcName)
      ..writeByte(2)
      ..write(obj.job)
      ..writeByte(3)
      ..write(obj.bStr)
      ..writeByte(4)
      ..write(obj.bDex)
      ..writeByte(5)
      ..write(obj.bInt)
      ..writeByte(6)
      ..write(obj.lvS)
      ..writeByte(7)
      ..write(obj.lvD)
      ..writeByte(8)
      ..write(obj.lvI)
      ..writeByte(9)
      ..write(obj.src)
      ..writeByte(10)
      ..write(obj.maxSrc)
      ..writeByte(11)
      ..write(obj.exp)
      ..writeByte(12)
      ..write(obj.diceAdv)
      ..writeByte(13)
      ..write(obj.atBonus)
      ..writeByte(14)
      ..write(obj.dfBonus)
      ..writeByte(15)
      ..write(obj.combat)
      ..writeByte(16)
      ..write(obj.gold)
      ..writeByte(17)
      ..write(obj.level)
      ..writeByte(18)
      ..write(obj.skillBook)
      ..writeByte(19)
      ..write(obj.weaponType)
      ..writeByte(20)
      ..write(obj.armorType)
      ..writeByte(21)
      ..write(obj.cStr)
      ..writeByte(22)
      ..write(obj.cDex)
      ..writeByte(23)
      ..write(obj.cInt)
      ..writeByte(24)
      ..write(obj.maxHp)
      ..writeByte(25)
      ..write(obj.hp)
      ..writeByte(26)
      ..write(obj.effects)
      ..writeByte(27)
      ..write(obj.inventory)
      ..writeByte(28)
      ..write(obj.itemStats)
      ..writeByte(29)
      ..write(obj.weapon)
      ..writeByte(30)
      ..write(obj.armor)
      ..writeByte(31)
      ..write(obj.accessory)
      ..writeByte(32)
      ..write(obj.hero)
      ..writeByte(33)
      ..write(obj.isAlive)
      ..writeByte(34)
      ..write(obj.skillCools)
      ..writeByte(35)
      ..write(obj.blowAvailable)
      ..writeByte(36)
      ..write(obj.link)
      ..writeByte(37)
      ..write(obj.lastTarget)
      ..writeByte(38)
      ..write(obj.aggro)
      ..writeByte(39)
      ..write(obj.barrier)
      ..writeByte(40)
      ..write(obj.tripleDamage)
      ..writeByte(41)
      ..write(obj.lastSource)
      ..writeByte(42)
      ..write(obj.levelUp)
      ..writeByte(43)
      ..write(obj.battleStart)
      ..writeByte(44)
      ..write(obj.turnStart)
      ..writeByte(45)
      ..write(obj.getDamage)
      ..writeByte(46)
      ..write(obj.getHp)
      ..writeByte(47)
      ..write(obj.heroes)
      ..writeByte(48)
      ..write(obj.enemies)
      ..writeByte(49)
      ..write(obj.timePoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
