import 'package:balance/Controller/data_base_helper.dart';
import 'package:balance/Model/person_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum Counter { increment, decrement }

class PersonController extends GetxController {
  late final TextEditingController nameController;
  late final TextEditingController balanceController;
  late final TextEditingController initialAmountController;
  late final TextEditingController discreptionController;
  RxInt totalBalanceAmount = 0.obs;
  RxInt totalAdvanceAmount = 0.obs;
  RxInt balanceText = 0.obs;
  

  getBalanceAmount() {
    List<Person> totalPersons = personBox.values.toList();
// this method (fold) is calculating total amount of list
// 0 statnd for initial amount sum is added value + persons amount
    int balanceAmount = totalPersons.fold(0, (sum, person) => sum + person.balance);
    totalBalanceAmount.value = balanceAmount;
    // print(totalBalanceAmount.toString());
    int advanceAmount = totalPersons.fold(0, (sum, person) => sum + person.initialAmount);
    totalAdvanceAmount.value = advanceAmount;
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
    getBalanceAmount();
  }

  updatePersonBox({required int index, required Person person}) async {
    await personBox.putAt(index, person);
    // update method is from get package
    // it update getBuilder to build...
    update();
    getBalanceAmount();
  }

  deletePersonBox({required int index}) async {
    await personBox.deleteAt(index);
    update();
    getBalanceAmount();
  }

  countterButtonClicked(Counter buttonEvent) {
    int i = int.parse(balanceController.text);
    if (buttonEvent == Counter.increment) {
      balanceText.value += i;
    } else if (buttonEvent == Counter.decrement) {
      balanceText.value -= i;
    }
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
