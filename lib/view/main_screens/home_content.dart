import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';
import 'package:streamline/constants/colors.dart';
import 'package:streamline/controller/all_tasksController.dart';
import 'package:streamline/controller/habits_controller.dart';
import 'package:streamline/view/widgets/dialog_box.dart';
import 'package:streamline/view/widgets/home_widgets.dart';

import '../../constants/firebase_constants.dart';
import '../../controller/activity_controller.dart';
import '../../controller/auth_controller.dart';
import '../../controller/todo_controller.dart';
import '../../controller/users_controller.dart';
import '../widgets/activity_tile.dart';
import '../widgets/add_activity.dart';
import '../widgets/edit_activity.dart';
import '../widgets/todo_tile.dart';

class HomeContentScreen extends StatelessWidget {
  HomeContentScreen({super.key});

  final _controller = TextEditingController();

  void startActivity(int index) {
    ActivitiesController controller = Get.find<ActivitiesController>();
    // start time
    var startTime = DateTime.now();
    // include the time thats elapes
    int elapsedTime = controller.activities[index].timeSpent;
    //activity started or stopped
    controller.activities[index].started =
        !controller.activities[index].started;
    
    // if activity started then start timer
    if (controller.activities[index].started &&
        !controller.activities[index].isCompleted) {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        // cancel if activity stopped
        if (!controller.activities[index].started) {
          timer.cancel();
        }
        
        var currentTime = DateTime.now();
        controller.activities[index].timeSpent = elapsedTime +
            currentTime.second -
            startTime.second +
            60 * (currentTime.minute - startTime.minute) +
            60 * 60 * (currentTime.hour - startTime.hour);

        if ((controller.activities[index].timeSpent * 1000) ==
            (controller.activities[index].timeGoal * 60 * 1000)) {
          controller.activities[index].isCompleted = true;
          controller.activities[index].started = false;
      
          controller.saveActivity(
              uid: controller.uid,
              actvId: controller.activities[index].actvId,
              timeSpent: controller.activities[index].timeSpent,
              started: controller.activities[index].started,
              isCompleted: controller.activities[index].isCompleted,
              timeCompleted: Timestamp.now());

          controller.addActivityToHistory(
              content: controller.activities[index].content,
              timeAdded: controller.activities[index].timeAdded);
          timer.cancel();
        } else {
          controller.saveActivity(
            uid: controller.uid,
            actvId: controller.activities[index].actvId,
            timeSpent: controller.activities[index].timeSpent,
            started: controller.activities[index].started,
            isCompleted: controller.activities[index].isCompleted,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void addActivity() {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddActivityDialog(),
            );
          });
    }

    void editActivity(int index) {
      debugPrint('pressed');
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: EditActivityDialog(
                index: index,
              ),
            );
          });
    }

    return Scaffold(
        backgroundColor: const Color(0xFFFDEAC1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDEAC1),
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      image: AssetImage('assets/images/home/homebg.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(children: [
                      const SizedBox(height: 50),
                      CurrentDateWidget(),
                      const SizedBox(height: 35),
                      Row(
                        children: [
                          const Text('Hello, ',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w100)),
                          GetX<UserController>(
                            initState: (_) async {
                              Get.find<UserController>().user =
                                  await userController.getUser(
                                      Get.find<AuthController>().user.uid);
                            },
                            builder: (_) {
                              if (_.user.name != null) {
                                return Text(_.user.name!.capitalize(),
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600));
                              } else {
                                return const Text("loading...");
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetX<ActivitiesController>(
                            initState: (_) async {
                              Get.find<ActivitiesController>();
                            },
                            builder: (controller) {
                              return DailyStatsTab(
                                label: 'Activites Done',
                                completed: controller
                                    .numberOfCompletedActivitiesToday(),
                              );
                            },
                          ),
                          DailyStatsTab(
                            label: 'Habits Done',
                            completed: Get.find<HabitsController>()
                                .numberOfCompletedHabitsToday(),
                          ),
                          GetX<TodosController>(
                            initState: (_) async {
                              Get.find<TodosController>();
                            },
                            builder: (controller) {
                              return DailyStatsTab(
                                label: 'To do\'s Done',
                                completed:
                                    Get.find<TodosController>()
                                .numberOfCompletedTodosToday(),
                              );
                            },
                          ),
                        ],
                      )
                    ]),
                  )),
              Container(
                  width: double.infinity,
                  //height: MediaQuery.of(context).size.height ,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 20,
                        blurRadius: 30,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 40, bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Activities',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                  height: 25,
                                  width: 60,
                                  child: PlusButton(
                                    onPressed: () => addActivity(),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        GetX<ActivitiesController>(
                          initState: (_) async {
                            Get.find<ActivitiesController>();
                          },
                          builder: (controller) {
                            return Container(
                              height: 165,
                              child: controller.activities.isEmpty
                                  ? Center(
                                      child: TextButton(
                                      onPressed: addActivity,
                                      child: const Text(
                                          'Add Your Daily Activities Here!',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.orange2)),
                                    ))
                                  : Container(
                                      child: ListView.builder(
                                        itemCount: controller.activities.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) {
                                          return ActivityTile(
                                            onPlay: () {
                                              startActivity(index);
                                            },
                                            activity:
                                                controller.activities[index],
                                            onDoubleTap: () =>
                                                editActivity(index),
                                            onDone: () =>
                                                controller.restartActivity(
                                                    actvId: controller
                                                        .activities[index]
                                                        .actvId,
                                                    uid: controller.uid),
                                          );
                                        }),
                                      ),
                                    ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('To do\'s',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 25,
                                width: 60,
                                child: PlusButton(
                                  // addTodo-btn key
                                  key: const ValueKey('addTodo-btn'),
                                  onPressed: () => showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: DialogBox(
                                            controller: _controller,
                                            onCancel: () {
                                              Get.back();
                                              _controller.clear();
                                            },
                                            onAdd: () {
                                              todosController.addTodo(
                                                  content: _controller.text);
                                              _controller.clear();
                                              Get.back();
                                            }),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GetX<TodosController>(
                          initState: (_) async {
                            Get.find<TodosController>();
                          },
                          builder: (controller) {
                            return Container(
                              constraints: const BoxConstraints(minHeight: 190),
                              child: Get.find<TodosController>().todos.isEmpty
                                  ? Center(
                                      child: TextButton(
                                        onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogBox(
                                                controller: _controller,
                                                onCancel: () {
                                                  Get.back();
                                                  _controller.clear();
                                                },
                                                onAdd: () {
                                                  todosController.addTodo(
                                                      content:
                                                          _controller.text);
                                                  _controller.clear();
                                                });
                                          },
                                        ),
                                        child: const Text(
                                            'Add Your Daily Todos Here!',
                                            style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.orange2)),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 10),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.todos.length,
                                      itemBuilder: (context, index) {
                                        return TodoTile(
                                          todo: controller.todos[index],
                                          uid: controller.uid,
                                          onChanged: (value) {
                                            if (value == true) {
                                              controller.completeTodo(
                                                  controller.uid,
                                                  controller
                                                      .todos[index].todoId);
                                              controller.addTodoToHistory(
                                                  content: controller
                                                      .todos[index].content,
                                                  timeAdded: controller
                                                      .todos[index].timeAdded);
                                            } else {
                                              controller.uncompleteTodo(
                                                  controller.uid,
                                                  controller
                                                      .todos[index].todoId);
                                              controller.deleteTodoFromHistory(
                                                  controller.uid,
                                                  controller.todosHistory[index]
                                                      .todoId);
                                            }
                                          },
                                          deleteFunction: (BuildContext) {
                                            todosController.deleteTodo(
                                                controller.uid,
                                                controller.todos[index].todoId);
                                          },
                                        );
                                      }),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
