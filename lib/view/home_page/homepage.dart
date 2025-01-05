import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/home_page_controller.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/utils/dialogs.dart';
import 'package:todo/utils/firebase_service.dart';
import 'package:todo/view/completed_task/complete_task.dart';
import 'package:todo/view/custom_button/button.dart';
import 'package:todo/view/login/login.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.transparent;
  }

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
                      IconButton(
                          onPressed: () async {
                            await FirebaseService()
                                .deleteAllTaskToFirebase(controller.allDocId);
                            controller.allDocId.clear();
                            controller.update();
                          },
                          icon: Icon(Icons.delete)),
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
                                    data.copyWith(status: 'Completed');
                                FirebaseService()
                                    .updateTaskToFirebase(dataUpdate);
                              },
                              icon: const Icon(
                                  Icons.check_circle_outline_outlined)),
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
                                      onPressed: () {
                                        TodoDialog()
                                            .showEditTaskDialog(context, data);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
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
            floatingActionButton: FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: Color(0xffFF5A5F),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => TodoDialog().showTaskDialog(context)),
          );
        });
  }
}
