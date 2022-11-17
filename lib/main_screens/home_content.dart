import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:streamline/widgets/home_widgets.dart';

class HomeContentScreen extends StatefulWidget {
  final String documentId;
  const HomeContentScreen({super.key, required this.documentId});

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  late String name;

  List habitList = [
    // habtName - timeSpent secs - timeGoal mins - habitStarted
    ['Study', 0, 1, false],
    ['Work', 0, 60, false],
    ['Meditate', 0, 60, false],
  ];

  void habitStarted(int index) {
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
      Timer.periodic(Duration(seconds: 1), (timer) {
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

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            name = data['name'];

            return Scaffold(
                backgroundColor: Color(0xFFFDEAC1),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          color: Color(0xFFFDEAC1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(children: [
                              SizedBox(height: 50),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(date,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF312B26)
                                                .withOpacity(0.9),
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(width: 5),
                                    Icon(FeatherIcons.calendar)
                                  ]),
                              SizedBox(height: 35),
                              Row(
                                children: [
                                  Text('Hello, ',
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w100)),
                                  Text('$name!'.capitalize(),
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: 35),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  DailyStatsTab(label: 'Activited Done', completed: 2,),
                                  DailyStatsTab(label: 'Activited Done', completed: 2,),
                                  DailyStatsTab(label: 'Activited Done', completed: 2,),
                                  
                                ],
                              )
                            ]),
                          )),
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 20,
                                blurRadius: 30,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 40),
                            child: Column(
                              children: [
                                Container(
                                    height: 150,
                                    child: ListView.builder(
                                        itemCount: habitList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) {
                                          return HabitTile(
                                            habitName: habitList[index][0],
                                            timeSpent: habitList[index][1],
                                            timeGoal: habitList[index][2],
                                            habitStarted: habitList[index][3],
                                            onPressed: () {
                                              habitStarted(index);
                                            },
                                          );
                                        })))
                              ],
                            ),
                          )),
                    ],
                  ),
                ));
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF6E50),
            ),
          );
        });
  }
}

