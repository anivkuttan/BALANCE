import 'package:balance/Controller/get_controller.dart';
import 'package:balance/Model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPage extends StatefulWidget {
  final int? editedIndex;
  final Person? editedPerson;

  const AddPage({Key? key, this.editedIndex, this.editedPerson}) : super(key: key);

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
  void initState() {
    if (widget.editedIndex != null) {
      Person person = widget.editedPerson ?? Person(name: 'Name', balance: 0, initialAmount: 0);
      personController.nameController.text = person.name;
      personController.balanceController.text = person.balance.toString();
      personController.initialAmountController.text = person.initialAmount.toString();
      personController.discreptionController.text = person.discreption;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.editedIndex == null ? const Text('Add New Person') : const Text('Edit Person'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
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
                      int advanceAmount = int.parse(
                        personController.initialAmountController.text,
                      );
                      Person newPerson = Person(
                        name: personController.nameController.text,
                        balance: balance,
                        initialAmount: advanceAmount,
                        discreption: personController.discreptionController.text,
                      );
                      if (widget.editedIndex == null) {
                        personController.addPersonBox(person: newPerson);
                      } else {
                        personController.updatePersonBox(index: widget.editedIndex!, person: newPerson);
                      }
                      clearControllers();
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clearControllers() {
    personController.nameController.clear();
    personController.balanceController.clear();
    personController.initialAmountController.clear();
    personController.discreptionController.clear();
  }

  addButtonPressed() {}
  editButtonPressed() {}
}
