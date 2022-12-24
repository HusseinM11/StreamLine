import 'dart:async';
import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:streamline/model/task.dart';
import 'package:streamline/utils/date_time_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:streamline/controller/activity_controller.dart';
import 'package:streamline/controller/habits_controller.dart';
import 'package:streamline/controller/todo_controller.dart';
import 'package:streamline/model/habit.dart';

class AllTasksController extends GetxController {
  RxList<Task> completedTasks = RxList([]);

  @override
  void onInit() {
    super.onInit();

    completedTasks.clear();
    completedTasks.bindStream(completedTasksStream());
  }

  Stream<List<Task>> completedTasksStream() {
    final controller = StreamController<List<Task>>();
    this.completedTasks.clear();
    HabitsController habitsController = Get.find();
    ActivitiesController activitiesController = Get.find();
    TodosController todosController = Get.find();

    RxList<Task> completedTasks = RxList([]);

    completedTasks.addAll(habitsController.habitsHistory);
    completedTasks.addAll(activitiesController.activitiesHistory);
    completedTasks.addAll(todosController.todosHistory);

    // Add the initial list of completed tasks to the stream
    controller.add(completedTasks);

    // Return the stream
    return controller.stream;
  }

  int getCompletedTasks(DateTime d) {
    int count = 0;
    if (completedTasks.isEmpty) {
      return count;
    } else {
      for (var element in completedTasks) {
        if (element.timeCompleted!.toDate().isSameDate(d)) {
          count++;
        }
      }
      return count;
    }
  }

  List<int> getWeeklyStats() {
    var startOfWeek = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - (DateTime.now().weekday - 1));
    List<int> data = [];
    for (var i = 0; i < 7; i++) {
      var noOfTasks = 0;
      var day = startOfWeek.add(Duration(days: i));

      noOfTasks += getCompletedTasks(day);

      data.add(noOfTasks);
    }
    return data;
  }

  int getMostProductiveHour() {
    if (completedTasks.isNotEmpty) {
      List<int> hours = List.filled(24, 0);

      for (var element in completedTasks) {
        int hour = element.timeCompleted!.toDate().hour;
        hours[hour]++;
      }
      int max = 0;
      for (int i = 0; i < 24; i++) {
        if (hours[i] > hours[max]) {
          max = i;
        }
      }
      return max;
    } else {
      return -5;
    }
  }

  DateTime? getMostProductiveDay() {
    final Map<DateTime, int> hours = HashMap();
    for (var e in completedTasks) {
      if (hours.containsKey(e.timeCompleted)) {
        hours.update(e.timeCompleted!.toDate(), (value) => value + 1);
      } else {
        hours.addAll({e.timeCompleted!.toDate(): 0});
      }
    }
    if (hours.isNotEmpty) {
      DateTime max = hours.keys.first;
      hours.forEach((key, value) {
        if (value > (hours[max] ?? 0)) {
          max = key;
        }
      });
      return max;
    }
    return null;
  }
}
