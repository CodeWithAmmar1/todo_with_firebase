import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/complete_task_controller.dart';
import 'package:todo/controller/home_page_controller.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/utils/firebase_service.dart';
import 'package:todo/view/login/login.dart';

class CompleteTask extends StatelessWidget {
  CompleteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteTaskController>(
        init: CompleteTaskController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("T O D O"),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await FirebaseService()
                                .deleteAllTaskToFirebase(controller.allDocId);
                            controller.allDocId.clear();
                            controller.update();
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.allTaskData.length,
                    itemBuilder: (context, index) {
                      // bool isChecked = false;
                      TaskModel data = controller.allTaskData[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            if (controller.allDocId.isNotEmpty) {
                              if (controller.allDocId.contains(data.docId) ==
                                  true) {
                                controller.allDocId.remove(data.docId ?? '');
                              } else {
                                controller.allDocId.add(data.docId ?? '');
                              }
                              controller.update();
                            }
                          },
                          onLongPress: () {
                            if (controller.allDocId.isEmpty) {
                              controller.allDocId.add(data.docId ?? '');
                              controller.update();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minTileHeight: 80,
                          tileColor:
                              controller.allDocId.contains(data.docId) == true
                                  ? Colors.red
                                  : Colors.grey,
                          leading: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                TaskModel dataUpdate =
                                    data.copyWith(status: 'Uncompleted');
                                FirebaseService()
                                    .updateTaskToFirebase(dataUpdate);
                              },
                              icon: const Icon(
                                Icons.check_box_rounded,
                                color: Colors.black,
                              )),
                          title: Text(data.title),
                          subtitle: Text(
                            "${data.description}\nCompleted by: \n${controller.formatDate(data.completedByDate ?? DateTime(2024))} ${controller.formatTimeOfDay(data.completedByTime ?? TimeOfDay(hour: 0, minute: 0))}\nCreated at: ${controller.formatDate(data.createdAt)}",
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await FirebaseService()
                                            .deleteAllTaskToFirebase(
                                                [data.docId ?? ""]);
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: data.priority == 'High'
                                        ? Colors.red
                                        : data.priority == 'Low'
                                            ? Colors.green
                                            : Colors.amber,
                                    borderRadius: BorderRadius.circular(20)),
                                width: 50,
                                height: 20,
                                child: Center(child: Text(data.priority ?? '')),
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
