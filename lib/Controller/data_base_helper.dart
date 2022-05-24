import 'package:balance/Model/person_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBaseHelper {
  // box name
  static const String boxName = 'Person_db';
  // openning box
  static openBox() async => await Hive.openBox<Person>(boxName);
  //closing Box
  static closeBox() async {
    // await Hive.box(boxName).close();
    await Hive.close();
  }

  // call ing Box

}
