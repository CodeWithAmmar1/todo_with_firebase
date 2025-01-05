import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/home_page_controller.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/view/custom_button/button.dart';

class TodoDialog {
  void showPopupTodayTask(BuildContext context, String title, String message) {
    // Show a popup dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("dismiss"))
              ],
            ),
          ),
        );
      },
    );
  }

  void showEditTaskDialog(BuildContext context, TaskModel data) {
    final controller = Get.find<HomePageController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        controller.titleController.text = data.title;
        controller.descriptionController.text = data.description;
        controller.selectedPriority = data.priority;
        controller.selectedDate = data.completedByDate;
        controller.selectedTime = data.completedByTime;
        controller.titleController.text = data.title;

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
                          "Update Task",
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 2,
                            ),
                          ),
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
                              style: TextStyle(color: Color(0xffFF5A5F)),
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
                              style: TextStyle(color: Color(0xffFF5A5F)),
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
                        text: "Update Task",
                        onTap: () {
                          controller.validationForUpdate(data);
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffDEDEDE),
                              width: 2,
                            ),
                          ),
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
                              style: TextStyle(color: Color(0xffFF5A5F)),
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
                              style: TextStyle(color: Color(0xffFF5A5F)),
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
