import 'package:balance/Controller/get_controller.dart';
import 'package:balance/Model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditPage extends StatefulWidget {
  final int? editedIndex;
  final Person? editedPerson;

  const AddEditPage({Key? key, this.editedIndex, this.editedPerson}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddEditPage> {
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
    if (widget.editedPerson == null) {
      clearControllers();
    } else {
      personController.nameController.text = widget.editedPerson!.name;
      personController.balanceController.text = '0';
      personController.balanceText.value = widget.editedPerson!.balance;
      personController.initialAmountController.text = widget.editedPerson!.initialAmount.toString();
      personController.discreptionController.text = widget.editedPerson!.discreption;
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
              widget.editedIndex == null
                  ? TextFormField(
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
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 120,
                          child: TextFormField(
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
                        ),
                        const SizedBox(width: 20),
                        Obx(() {
                          return Text(
                            personController.balanceText.value.toString(),
                            style: const TextStyle(fontSize: 30),
                          );
                        }),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          child: const Text(
                            "-",
                            style: TextStyle(fontSize: 35),
                          ),
                          onPressed: () {
                            personController.countterButtonClicked(Counter.decrement);
                          },
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text(
                            "+",
                            style: TextStyle(fontSize: 35),
                          ),
                          onPressed: () {
                            personController.countterButtonClicked(Counter.increment);
                          },
                        ),
                      ],
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
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: widget.editedIndex == null ? const Text("Add") : const Text('Save'),
                  onPressed: () {
                    var validate = formKey.currentState!.validate();
                    showSnackBarOnScreen();
                    if (validate) {
                      int balance = personController.balanceText.value;
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
                      personController.getBalanceAmount();
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

  showSnackBarOnScreen() {
    SnackBar snacBar = const SnackBar(
      content: Text('Please Fill Form'),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snacBar);
  }

  void clearControllers() {
    personController.nameController.clear();
    personController.balanceController.clear();
    personController.initialAmountController.clear();
    personController.discreptionController.clear();
  }
}
