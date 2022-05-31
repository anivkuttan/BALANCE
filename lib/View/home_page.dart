import 'package:balance/Controller/get_controller.dart';
import 'package:balance/Model/person_model.dart';
import 'package:balance/View/add_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String rupeeSymbol = '₹';

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
          BuildContainer(personController: personController),
          const SizedBox(height: 20),
          Expanded(
            child: GetBuilder<PersonController>(
              builder: ((controller) {
                bool emptyList = controller.personBox.isEmpty;

                if (emptyList) {
                  return const Center(
                    child: Text('Empty Persons'),
                  );
                }else{
                  return  ListView.separated(
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
                                color:
                                    person.balance.isNegative ? Colors.red : const Color.fromARGB(255, 101, 141, 232),
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
                            color: const Color.fromARGB(255, 139, 198, 240),
                            alignment: Alignment.center,
                            height: 200,
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
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}

class BuildContainer extends StatelessWidget {
  const BuildContainer({
    Key? key,
    required this.personController,
  }) : super(key: key);

  final PersonController personController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(23),
      ),
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(children: [
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 1, 32, 86),
                Color.fromARGB(255, 4, 120, 215),
              ]),
              color: Colors.blueAccent[400],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(23),
                bottomLeft: Radius.circular(23),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildBalanceTExtWidegt(personController: personController),
                  const SizedBox(height: 30),
                  BuildAdvanceAmountWidget(personController: personController),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
        const BuildAddNewPart(),
      ]),
    );
  }
}

class BuildAddNewPart extends StatelessWidget {
  const BuildAddNewPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) {
            return const AddEditPage();
          });
          Navigator.of(context).push(route);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23),
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.add, color: Colors.white),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class BuildAdvanceAmountWidget extends StatelessWidget {
  const BuildAdvanceAmountWidget({
    Key? key,
    required this.personController,
  }) : super(key: key);

  final PersonController personController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Total Amount :",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        Obx(() {
          return Text(
            personController.totalAdvanceAmount.toString(),
            style: const TextStyle(fontSize: 23, color: Colors.white),
          );
        }),
      ],
    );
  }
}

class BuildBalanceTExtWidegt extends StatelessWidget {
  const BuildBalanceTExtWidegt({
    Key? key,
    required this.personController,
  }) : super(key: key);

  final PersonController personController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Total Balance :',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          width: 30,
        ),
        Obx(() {
          return Text(
            personController.totalBalanceAmount.toString(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          );
        }),
      ],
    );
  }
}
