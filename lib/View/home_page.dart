import 'package:balance/Controller/get_controller.dart';
import 'package:balance/Model/person_model.dart';
import 'package:balance/View/add_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersonController personController = Get.put(PersonController());
  @override
  void initState() {
    personController.getBalanceAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(23),
              ),
              height: 200,
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                   const   Text(
                        'Total Balance Amount ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Obx(() {
                        return Text(
                          personController.totalBalanceAmount.toString(),
                          style: const TextStyle(fontSize: 30),
                        );
                      })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Total Initial Amount "),
                      Obx(() {
                        return Text(
                          personController.totalAdvanceAmount.toString(),
                          style: const TextStyle(fontSize: 30),
                        );
                      }),
                      FloatingActionButton(
                        child: const Icon(Icons.add, color: Colors.black),
                        onPressed: () {
                          Route route = MaterialPageRoute(builder: (context) {
                            return const AddEditPage();
                          });
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  )
                ],
              )),
          const SizedBox(height: 20),
          Expanded(
            child: GetBuilder<PersonController>(builder: ((controller) {
              return ListView.separated(
                itemCount: controller.personBox.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Person? person = controller.personBox.getAt(index);
                  return Card(
                    child: ExpansionTile(
                      textColor: Colors.black,
                      tilePadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      title: Row(
                        children: [
                          Text(person!.name),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: person.balance.isNegative ? Colors.red : Colors.green,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            alignment: Alignment.center,
                            child: Text(person.balance.toString(), style: const TextStyle(fontSize: 30)),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "Advance Amount : ${person.initialAmount}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 200, 205, 200),
                          alignment: Alignment.center,
                          height: 260,
                          child: Column(
                            children: [
                              Text(person.discreption),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    label: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      controller.deletePersonBox(index: index);
                                    },
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      Route route = MaterialPageRoute(builder: (context) {
                                        return AddEditPage(
                                          editedIndex: index,
                                          editedPerson: person,
                                        );
                                      });
                                      Navigator.of(context).push(route);
                                    },
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Edit'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            })),
          )
        ],
      ),
    );
  }
}
