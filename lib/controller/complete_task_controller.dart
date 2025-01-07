import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/utils/firebase_service.dart';

class CompleteTaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedPriority;
  List<TaskModel> allTaskData = [];
  List<String> allDocId = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTaskListner();
  }

  void getTaskListner() async {
    FirebaseService().listenToTasksFromFirebase('Completed').listen(
      (allTask) {
        allTaskData.clear();

        allTaskData.addAll(allTask);
        update();
      },
    );
  }

  void pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      update();
    }
  }

  timePickDate(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
      update();
    }
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod; // Adjust hour for 12-hour format
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }

  // void validation() {
  //   if (titleController.text.isEmpty ||
  //       descriptionController.text.isEmpty ||
  //       selectedDate == null ||
  //       selectedTime == null ||
  //       selectedPriority == null) {
  //     var snackBar = SnackBar(
  //       content: const Text('All fields are required'),
  //       backgroundColor: const Color(0xffFF5A5F),
  //       behavior: SnackBarBehavior.fixed,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       elevation: 6.0,
  //       duration: const Duration(seconds: 2),
  //     );
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  //   } else {
  //     TaskModel taskData = TaskModel(
  //         title: titleController.text,
  //         description: descriptionController.text,
  //         status: 'Uncompleted',
  //         completedByDate: selectedDate,
  //         priority: selectedPriority,
  //         createdAt: DateTime.now(),
  //         completedByTime: selectedTime);
  //     FirebaseService().addTaskToFirebase(taskData);

  //     var snackBar = SnackBar(
  //       content: const Text('Task Added sucessfully!!'),
  //       backgroundColor: Colors.green,
  //       behavior: SnackBarBehavior.fixed,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       elevation: 6.0,
  //       duration: const Duration(seconds: 2),
  //     );
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  //     Navigator.pop(Get.context!);
  //     titleController.clear();
  //     descriptionController.clear();
  //     selectedDate = null;
  //     selectedTime = null;
  //     selectedPriority = null;
  //     update();
  //   }
  // }

  // void validationForUpdate(TaskModel data) {
  //   if (titleController.text.isEmpty ||
  //       descriptionController.text.isEmpty ||
  //       selectedDate == null ||
  //       selectedTime == null ||
  //       selectedPriority == null) {
  //     var snackBar = SnackBar(
  //       content: const Text('All fields are required'),
  //       backgroundColor: const Color(0xffFF5A5F),
  //       behavior: SnackBarBehavior.fixed,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       elevation: 6.0,
  //       duration: const Duration(seconds: 2),
  //     );
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  //   } else {
  //     TaskModel taskData = TaskModel(
  //         title: titleController.text,
  //         description: descriptionController.text,
  //         status: 'Uncompleted',
  //         docId: data.docId,
  //         completedByDate: selectedDate,
  //         priority: selectedPriority,
  //         createdAt: data.createdAt,
  //         completedByTime: selectedTime);
  //     FirebaseService().updateTaskToFirebase(taskData);

  //     var snackBar = SnackBar(
  //       content: const Text('Task Updated sucessfully!!'),
  //       backgroundColor: Colors.green,
  //       behavior: SnackBarBehavior.fixed,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       elevation: 6.0,
  //       duration: const Duration(seconds: 2),
  //     );
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  //     Navigator.pop(Get.context!);
  //     titleController.clear();
  //     descriptionController.clear();
  //     selectedDate = null;
  //     selectedTime = null;
  //     selectedPriority = null;
  //     update();
  //   }
  // }
}
