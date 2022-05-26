import 'package:balance/Controller/data_base_helper.dart';
import 'package:balance/Model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:balance/View/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // checking adapter is registerd or not if its not registerd yhen register
  if (!Hive.isAdapterRegistered(PersonAdapter().typeId)) {
    Hive.registerAdapter(PersonAdapter());
  }
  await DataBaseHelper.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
