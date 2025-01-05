import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/control/home_page_controller.dart';
import 'package:todo/view/login/login.dart';

class CompleteTask extends StatelessWidget {
  const CompleteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("T O D O"),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      bool isChecked = false;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          minTileHeight: 80,
                          tileColor: Colors.grey,
                          leading: Checkbox(
                            value: isChecked, // Use the state variable here
                            onChanged: (bool? newValue) {
                              // Handle checkbox state change

                              isChecked = newValue ?? false;
                              controller.update();
                            },
                          ),
                          title: Text("Title"),
                          subtitle: Text("Description"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20)),
                                width: 50,
                                height: 20,
                                child: Center(child: Text("HIGH")),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
