import 'package:balance/Model/person.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PersonController extends GetxController {
  late final TextEditingController nameController;
  late final TextEditingController balanceController;
  late final TextEditingController initialAmountController;
  late final TextEditingController discreptionController;

  RxList<Person> personList = <Person>[
    Person(
      name: 'Anikuttan',
    )
  ].obs;
  @override
  void onInit() {
    nameController = TextEditingController();
    balanceController = TextEditingController();
    initialAmountController = TextEditingController();
    discreptionController = TextEditingController();
    super.onInit();
  }
}
