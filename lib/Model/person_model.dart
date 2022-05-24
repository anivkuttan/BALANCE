import 'package:hive_flutter/hive_flutter.dart';
part 'person_model.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int balance;
  @HiveField(2)
  int initialAmount;
  @HiveField(3)
  String discreption;

  Person({
    required this.name,
    this.balance = 0,
    this.initialAmount = 0,
    this.discreption = '',
  });
}
