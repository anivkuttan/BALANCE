import 'package:balance/Controller/get_controller.dart';
import 'package:balance/Model/person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final PersonController personController = Get.find();
  InputDecoration decoration = const InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(23),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Person'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: personController.nameController,
                  keyboardType: TextInputType.text,
                  decoration: decoration.copyWith(
                    label: const Text("Name"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: personController.balanceController,
                  keyboardType: TextInputType.number,
                   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Amount';
                    } else {
                      return null;
                    }
                  },
                  decoration: decoration.copyWith(
                    label: const Text('Amount'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: personController.initialAmountController,
                   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Advance Amount';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: decoration.copyWith(
                    label: const Text("Advance Amount"),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: personController.discreptionController,
                  keyboardType: TextInputType.multiline,
                  decoration: decoration.copyWith(
                    label: const Text("Discreption"),
                  ),
                  maxLines: 4,
                  
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("Add"),
                    onPressed: () {
                      var validate = formKey.currentState!.validate();
                      if (validate) {
                        int balance = int.parse(personController.balanceController.text);
                        int advanceAmount =  int.parse(
                            personController.initialAmountController.text,
                          );
                        Person newPerson = Person(
                          name: personController.nameController.text,
                          balance: balance,
                          initialAmount:advanceAmount,
                          discreption: personController.discreptionController.text,
                        );
                        personController.personList.add(newPerson);
                        clearControllers();
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),);
  }

  void clearControllers() {
    personController.nameController.clear();
    personController.balanceController.clear();
    personController.initialAmountController.clear();
    personController.discreptionController.clear();
  }
}
