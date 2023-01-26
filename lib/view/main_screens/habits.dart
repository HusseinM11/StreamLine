import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:streamline/constants/firebase_constants.dart';
import 'package:streamline/controller/habits_controller.dart';
import 'package:streamline/view/main_screens/progress.dart';
import 'package:streamline/view/main_screens/settings.dart';
import 'package:streamline/view/widgets/dialog_box.dart';
import 'package:streamline/view/widgets/habit_circle.dart';

import 'package:streamline/model/habit.dart';
import 'package:streamline/view/widgets/home_widgets.dart';
import '../sub_screens/edit_habit.dart';
import '../sub_screens/new_habit_screen.dart';
import '../../constants/colors.dart';
import '../widgets/snackbar.dart';
import 'home.dart';

class HabitsScreen extends StatelessWidget {
  final habitsController = Get.put(HabitsController(firestore: firebaseFirestore));
  HabitsScreen({super.key});

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
        body: Stack( alignment: AlignmentDirectional.bottomEnd, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
            child: Container(
              alignment: AlignmentDirectional.topEnd,
              child: CurrentDateWidget(),
                      
            ),
            
            
          ),
          
          
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/habits/background.png'),
                      fit: BoxFit.fill))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
            child: GetX<HabitsController>(builder: (controller) {
              return controller.habits.isEmpty ? Center(
                child: SizedBox(
                            width: double.infinity,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  color: AppColors.orange2,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600,
    
                                  height: 1.4),
                              child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText('Add a habit to get started by clicking the + button below.', textAlign: TextAlign.center,
                                      speed: Duration(milliseconds: 40)),
                                ],
                              ),
                            ),),
              )
                        : GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 40,
                children: List.generate(controller.habits.length, (index) {
                  return GestureDetector(
                      onLongPress: () {
                       
                        if (controller.habits[index].completedCount ==
                            controller.habits[index].repeatDaily) {
                          MyMessageHandler.showSnackBar(_scaffoldKey,
                              'You\'ve already finished this habit for the day!');
                        } else if (controller.habits[index].repeatDaily -
                                controller.habits[index].completedCount ==
                            1) {
                              //check if the habit is already in the habitsHistory list inside the controller
                              //if it is, then don't add it again
                              //if it isn't, then add it
                              

                          controller.addHabitToHistory(
                              content: controller.habits[index].content,
                              repeat: controller.habits[index].repeatDaily,
                              timeAdded: controller.habits[index].timeAdded);
                          
                          controller.completeHabit(
                            index: index,
                              habitId: controller.habits[index].habitId,
                              uid: controller.uid,
                              completedCount:
                                  controller.habits[index].completedCount,
                              repeat: controller.habits[index].repeatDaily);
                        } else {
                          controller.increaseCount(
                              uid: controller.uid,
                              habitId: controller.habits[index].habitId,
                              completedCount:
                                  controller.habits[index].completedCount);
                        }
                      },
                      onDoubleTap: () {
                        editHabit(index, _scaffoldKey);
                      },
                      child: HabitCircle(
                        habit: controller.habits[index],
                        uid: controller.uid,
                      ));
                }),
              );
            }),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                  backgroundColor: AppColors.orange2,
                  onPressed: () {
                    habitsController.habits.length == 6
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
