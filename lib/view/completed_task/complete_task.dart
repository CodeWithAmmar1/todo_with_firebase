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
                  Text(
                    "T O D O",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xffFF5A5F),
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await FirebaseService()
                                .deleteAllTaskToFirebase(controller.allDocId);
                            controller.allDocId.clear();
                            controller.update();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
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
                                  : Colors.green.withOpacity(0.3),
                          leading: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                TaskModel dataUpdate =
                                    data.copyWith(status: 'Uncompleted');
                                FirebaseService()
                                    .updateTaskToFirebase(dataUpdate);
                              },
                              icon: const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 20, 224, 27),
                              )),
                          title: Text(data.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.description,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Completed by: ",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "\n${controller.formatDate(data.completedByDate ?? DateTime(2024))} ${controller.formatTimeOfDay(data.completedByTime ?? const TimeOfDay(hour: 0, minute: 0))}" // The normal part
                                      ,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Created at: ",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          controller.formatDate(data.createdAt),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
