import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/colors.dart';

import '../controller/habits_controller.dart';

class HabitCircle extends StatelessWidget {
  bool habitDone = false;
  final String habitName;
  final int habitCount;
  final IconData icon;
  final int repeatDaily;

  HabitCircle({
    super.key,
    required this.habitDone,
    required this.habitName,
    required this.habitCount,
    required this.icon,
    required this.repeatDaily,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HabitsController>(builder: (controller) {
      return Column(
        children: [
          Flexible(
            child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: habitDone ? AppColors.orange : Colors.transparent,
                    border: Border.all(
                        color:
                            !habitDone ? AppColors.orange : Colors.transparent,
                        width: 7)),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Icon(icon,
                          size: 60,
                          /* color: !habitDone!
                                ? AppColors.darkGrey
                                : habitDone!
                                    ? Colors.white
                                    : Colors.white), */
                          color:
                              !habitDone ? AppColors.darkGrey : Colors.white),
                      const SizedBox(height: 10),
                      Text(habitCount.toString() + ' / ' + repeatDaily.toString(),
                          style: TextStyle(
                              color:
                                  habitDone ? Colors.white : AppColors.darkGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 5),
          Text(habitName,
            textAlign: TextAlign.center,
              style: const TextStyle(

                  color: AppColors.darkGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w700))
        ],
      );
    });
  }
}
/* 
Text( habitCount.toString(),
                        style: TextStyle(
                            color:
                                habitDone! ? Colors.white : AppColors.darkGrey,
                            fontSize: 24,
                            fontWeight: FontWeight.w700)), */