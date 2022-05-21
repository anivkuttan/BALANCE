import 'package:balance/Controller/get_controller.dart';
import 'package:balance/Model/person.dart';
import 'package:balance/View/add_page.dart';
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
                    children: const [
                      Text('Total Balance Amount '),
                      Text('45'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Total Initial Amount "),
                      FloatingActionButton(
                        onPressed: () {
                          Route route = MaterialPageRoute(builder: (context) {
                            return const AddPage();
                          });
                          Navigator.of(context).push(route);
                        },
                        child: const Icon(Icons.add, color: Colors.black),
                      )
                    ],
                  )
                ],
              )),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              return ListView.separated(
                itemCount: personController.personList.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Person person = personController.personList[index];
                  return Card(
                    child: ExpansionTile(
                      textColor: Colors.black,
                      tilePadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      title: Row(
                        children: [
                          Text(person.name),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 80,

                            decoration: BoxDecoration(
                              color: person.balance.isNegative?Colors.red:Colors.green,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            alignment: Alignment.center,
                            child: Text(person.balance.toString(),style:const TextStyle(fontSize: 30)),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "Advance Amount : ${person.initialAmount}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      children: [
                        Container(
                          color: Colors.green,
                          alignment: Alignment.center,
                          height: 260,
                          child: Text(person.discreption),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
