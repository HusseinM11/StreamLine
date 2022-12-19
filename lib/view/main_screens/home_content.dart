import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:intl/intl.dart';
import 'package:streamline/widgets/dialog_box.dart';
import 'package:streamline/widgets/home_widgets.dart';

import '../../constants/colors.dart';
import '../../constants/firebase_constants.dart';
import '../../controller/activity_controller.dart';
import '../../controller/auth_controller.dart';
import '../../controller/todo_controller.dart';
import '../../controller/users_controller.dart';
import '../../widgets/activity_tile.dart';
import '../../widgets/add_activity.dart';
import '../../widgets/edit_activity.dart';
import '../../widgets/todo_tile.dart';

class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({super.key});

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  String name = 'elya';
  final _controller = TextEditingController();

  List habitList = [
    // habtName - timeSpent secs - timeGoal mins - habitStarted
    ['Study', 0, 1, false],
    ['Work', 0, 60, false],
    ['Meditate', 0, 60, false],
  ];

  void startActivity(int index) {
    // start time
    var startTime = DateTime.now();

    // include the time thats elapes
    int elapsedTime = habitList[index][1];

    //habit started or stopped
    setState(() {
      habitList[index][3] = !habitList[index][3];
    });
    // check if habit started or stopped
    if (habitList[index][3]) {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          // cancel if habit stopped
          if (!habitList[index][3]) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          habitList[index][1] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void addActivity() {
    showDialog(
        context: context,
        builder: (context) {
          return EditActivityDialog(index: 1);
        });
  }

  void editActivity(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return //EditActivityDialog(index: index,);
              AddActivityDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFDEAC1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  color: const Color(0xFFFDEAC1),
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
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600));
                              } else {
                                return Text("loading...");
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          DailyStatsTab(
                            label: 'Activites Done',
                            completed: 2,
                          ),
                          DailyStatsTab(
                            label: 'Habits Done',
                            completed: 2,
                          ),
                          DailyStatsTab(
                            label: 'To do\'s Done',
                            completed: 2,
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
                        horizontal: 10.0, vertical: 40),
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
                        SizedBox(height: 15),
                        Container(
                          height: 150,
                          child: GetX<ActivitiesController>(
                            initState: (_) async {
                              Get.find<ActivitiesController>();
                            },
                            builder: (controller) {
                              return ListView.builder(
                                itemCount: controller.activities.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print('pressed');
                                      EditActivityDialog(index: index);
                                    },
                                    child: ActivityTile(
                                      onPressed: () {
                                        startActivity(index);
                                      },
                                      activity: controller.activities[index],
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
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
                        Container(
                          constraints: BoxConstraints(minHeight: 300),
                          //height: MediaQuery.of(context).size.height,

                          child: GetX<TodosController>(
                            initState: (_) async {
                              Get.find<TodosController>();
                            },
                            builder: (controller) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 10),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.todos.length,
                                  itemBuilder: (context, index) {
                                    return TodoTile(
                                      todo: controller.todos[index],
                                      uid: controller.uid,
                                      onChanged: (value) {
                                        if (value == true) {
                                          controller.completeTodo(
                                              controller.uid,
                                              controller.todos[index].todoId);
                                        } else {
                                          controller.uncompleteTodo(
                                              controller.uid,
                                              controller.todos[index].todoId);
                                        }
                                      },
                                      deleteFunction: (BuildContext) {
                                        todosController.deleteTodo(
                                            controller.uid,
                                            controller.todos[index].todoId);
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
