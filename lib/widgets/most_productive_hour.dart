import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:streamline/constants/colors.dart';
import 'package:streamline/controller/all_tasksController.dart';
import 'package:streamline/utils/time_of_day_util.dart';

class MostProductiveHour extends StatelessWidget {
  const MostProductiveHour({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      color: AppColors.orange2,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15, vertical:10),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text("Most Productive Hour",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            const SizedBox(height: 10),
            GetX<AllTasksController>(
              initState: (_) async {
                Get.find<AllTasksController>();
              },
              builder: (controller) {
                return Text(
                  controller.getMostProductiveHour() == -5 ? 'Nan' :
                  DateFormat.j().format(timeOfDayToDateTime(TimeOfDay(
                          hour: controller.getMostProductiveHour(), minute: 0)) ??
                      DateTime.now()),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                );
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
