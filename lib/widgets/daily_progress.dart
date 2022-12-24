import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:streamline/controller/todo_controller.dart';

import '../constants/colors.dart';
import '../controller/activity_controller.dart';
import '../controller/habits_controller.dart';

class DailyProgressTab extends StatelessWidget {
  const DailyProgressTab({super.key});

  int totalTasksCompletedToday() {
    int total = Get.find<HabitsController>().numberOfCompletedHabitsToday() +
        Get.find<ActivitiesController>().numberOfCompletedActivitiesToday() +
        Get.find<TodosController>().numberOfCompletedTodosToday();

    return total;
  }

  int totalTasks() {
    int total = Get.find<HabitsController>().habits.length +
        Get.find<ActivitiesController>().activities.length +
        Get.find<TodosController>().todos.length;

    return total;
  }

  @override
  Widget build(BuildContext context) {
    double per;
    if (totalTasks() == 0) {
      per = 0;
    } else {
      per = totalTasksCompletedToday() / totalTasks();
    }
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0,
        color: AppColors.orange2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${totalTasksCompletedToday()}/${totalTasks()}',
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  const Text('Today\'s Progress',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Colors.white))
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircularPercentIndicator(
                    percent: per,
                    backgroundColor: Colors.white,
                    backgroundWidth: 10,
                    progressColor: AppColors.green,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    radius: 45,
                    lineWidth: 10,
                  ),
                  Text(
                    '${(per * 100).toInt()}%',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
