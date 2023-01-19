import 'package:hive/hive.dart';

part 'monster.g.dart';

@HiveType(typeId: 0)
class Monster {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late int age;
  Monster(this.name, this.age);
}
