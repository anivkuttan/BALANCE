import 'package:balance/Controller/data_base_helper.dart';
import 'package:balance/Model/person_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersonController extends GetxController {
  late final TextEditingController nameController;
  late final TextEditingController balanceController;
  late final TextEditingController initialAmountController;
  late final TextEditingController discreptionController;
  RxInt totalBalanceAmount = 0.obs;
  RxInt totalAdvanceAmount = 0.obs;

  getBalanceAmount() {
    var totalPersons = personBox.values.toList();
    // print("before adding amount ${totalPersons}");
    for (var person in totalPersons) {
      totalBalanceAmount += person.balance;
      // print("after adding amount${totalBalanceAmount}");
    }
  }

  Box<Person> personBox = Hive.box(DataBaseHelper.boxName);
  RxList<Person> personList = <Person>[
    Person(
      name: 'Anikuttan',
    )
  ].obs;

  addPersonBox({required Person person}) async {
    await personBox.add(person);
    update();
  }

  updatePersonBox({required int index, required Person person}) async {
    await personBox.putAt(index, person);
    // update method is from get package
    // it update getBuilder to build...
    update();
  }

  deletePersonBox({required int index}) async {
    await personBox.deleteAt(index);
    update();
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    balanceController = TextEditingController();
    initialAmountController = TextEditingController();
    discreptionController = TextEditingController();
    super.onInit();
  }
}
