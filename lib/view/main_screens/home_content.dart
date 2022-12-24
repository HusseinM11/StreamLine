import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';
import 'package:streamline/constants/colors.dart';
import 'package:streamline/controller/all_tasksController.dart';
import 'package:streamline/controller/habits_controller.dart';
import 'package:streamline/widgets/dialog_box.dart';
import 'package:streamline/widgets/home_widgets.dart';

import '../../constants/firebase_constants.dart';
import '../../controller/activity_controller.dart';
import '../../controller/auth_controller.dart';
import '../../controller/todo_controller.dart';
import '../../controller/users_controller.dart';
import '../../widgets/activity_tile.dart';
import '../../widgets/add_activity.dart';
import '../../widgets/edit_activity.dart';
import '../../widgets/todo_tile.dart';

class HomeContentScreen extends StatelessWidget {
  HomeContentScreen({super.key});

  String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  final _controller = TextEditingController();

  void startActivity(int index) {
    debugPrint('started');
    ActivitiesController controller = Get.find<ActivitiesController>();
    // start time
    var startTime = DateTime.now();

    // include the time thats elapes
    int elapsedTime = controller.activities[index].timeSpent;

    //habit started or stopped
    controller.activities[index].started =
        !controller.activities[index].started;
    /*  setState(() {
      habitList[index][3] = !habitList[index][3];
    }); */
    // check if habit started or stopped

    if (controller.activities[index].started &&
        !controller.activities[index].isCompleted) {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        // cancel if habit stopped
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
          print('if clause ran');
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
      showDialog(
          context: context,
          builder: (context) {
            return AddActivityDialog();
          });
    }

    void editActivity(int index) {
      debugPrint('pressed');
      showDialog(
          context: context,
          builder: (context) {
            return EditActivityDialog(
              index: index,
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
                      image: AssetImage('images/home/homebg.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(children: [
                      const SizedBox(height: 50),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(date,
                            style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xFF312B26).withOpacity(0.9),
                                fontWeight: FontWeight.w300)),
                        const SizedBox(width: 5),
                        const Icon(FeatherIcons.calendar)
                      ]),
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
                                    controller.numberOfCompletedTodosToday(),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Activities',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w600)),
                            SizedBox(
                                height: 25,
                                width: 60,
                                child: PlusButton(
                                  onPressed: () => addActivity(),
                                )),
                          ],
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
                                      child: Text(
                                          'Add Your Daily Activities Here!',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.orange2)),
                                    )
                                  : ListView.builder(
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
                                                      .activities[index].actvId,
                                                  uid: controller.uid),
                                        );
                                      }),
                                    ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Todo\'s',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 25,
                              width: 60,
                              child: PlusButton(
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
                                                  content: _controller.text);
                                              _controller.clear();
                                            });
                                      })),
                              // child: PlusButton(controller: _controller, todosController: todosController),
                            ),
                          ],
                        ),
                        GetX<TodosController>(
                          initState: (_) async {
                            Get.find<TodosController>();
                          },
                          builder: (controller) {
                            return Container(
                              constraints: const BoxConstraints(minHeight: 190),
                              //height: MediaQuery.of(context).size.height,

                              child: Get.find<TodosController>().todos.isEmpty
                                  ? const Center(
                                      child: Text('Add Your Daily Todos Here!',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.orange2)),
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
