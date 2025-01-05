import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/control/home_page_controller.dart';
import 'package:todo/view/completed_task/complete_task.dart';
import 'package:todo/view/custom_button/button.dart';
import 'package:todo/view/login/login.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("T O D O"),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            Get.to(() => CompleteTask());
                          },
                          icon: Icon(Icons.check_box)),
                      IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Get.offAll(Login());
                          },
                          icon: Icon(Icons.logout)),
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0xffFF5A5F),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => showTaskDialog(context)),
          );
        });
  }

  void showTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GetBuilder<HomePageController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Add New Task",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.titleController,
                        decoration: const InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedDate == null
                                ? "Pick a Date"
                                : "Date: ${controller.formatDate(controller.selectedDate ?? DateTime(2024))}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () => controller.pickDate(context),
                            child: const Text(
                              "Select Date",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedTime == null
                                ? "Pick a Time"
                                : "Time: ${controller.formatTimeOfDay(controller.selectedTime ?? const TimeOfDay(hour: 0, minute: 0))}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () => controller.timePickDate(context),
                            child: const Text(
                              "Select Time",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Priority",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor:
                                  controller.selectedPriority == "High"
                                      ? Colors.red
                                      : Colors.grey.shade300,
                            ),
                            onPressed: () {
                              controller.selectedPriority = "High";
                              controller.update();
                            },
                            child: const Text(
                              "High",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor:
                                  controller.selectedPriority == "Medium"
                                      ? Colors.orange
                                      : Colors.grey.shade300,
                            ),
                            onPressed: () {
                              controller.selectedPriority = "Medium";
                              controller.update();
                            },
                            child: const Text(
                              "Medium",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor:
                                  controller.selectedPriority == "Low"
                                      ? Colors.green
                                      : Colors.grey.shade300,
                            ),
                            onPressed: () {
                              controller.selectedPriority = "Low";
                              controller.update();
                            },
                            child: const Text(
                              "Low",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Button(
                        text: "Add Task",
                        onTap: () {
                          controller.validation();
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
