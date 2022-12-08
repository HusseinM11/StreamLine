import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:streamline/controller/habits_controller.dart';
import 'package:streamline/main_screens/progress.dart';
import 'package:streamline/main_screens/settings.dart';
import 'package:streamline/widgets/dialog_box.dart';
import 'package:streamline/widgets/habit_circle.dart';

import 'package:streamline/model/habit.dart';
import '../sub_screens/edit_habit.dart';
import '../sub_screens/new_habit_screen.dart';
import '../constants/colors.dart';
import '../widgets/snackbar.dart';
import 'home.dart';

class HabitsScreen extends StatefulWidget {
  final habitsController = Get.put(HabitsController());
  HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  editHabit(int index, _scaffoldkey) {
    Get.to(() => EditHabitScreen(
          index: index,
          scaffoldkey: _scaffoldkey,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFFDEAC1),
        body: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/habits/background.png'),
                      fit: BoxFit.fill))),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:25),
            child: GetBuilder<HabitsController>(builder: (controller) {
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 40,
                children: List.generate(controller.habits.length, (index) {
                  return GestureDetector(
                      onLongPress: () {
                        controller.completeHabit(index, _scaffoldKey);
                      },
                      onDoubleTap: () {
                        editHabit(index, _scaffoldKey);
                      },
                      child: HabitCircle(
                        habitName: controller.habits[index].habitName,
                        icon: controller.habits[index].icon,
                        habitCount: controller.habits[index].completedCount,
                        habitDone: controller.habits[index].isCompleted,
                        repeatDaily: controller.habits[index].repeatDaily,
                      ));
                }),
              );
            }),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                  backgroundColor: AppColors.orange,
                  onPressed: () {
                    widget.habitsController.habits.length == 6
                        ? MyMessageHandler.showSnackBar(_scaffoldKey,
                            'You\'ve already reached the maximum number of habits.')
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => NewHabitScreen()),
                            ),
                          );
                  },
                  elevation: 0,
                  child: Icon(FeatherIcons.plus, size: 30))),
        ]),
      ),
    );
  }
}
