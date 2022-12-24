import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/FontAwesome.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:streamline/model/habit.dart';

import 'package:streamline/view/main_screens/habits.dart';

import '../../controller/habits_controller.dart';
import '../../constants/colors.dart';
import '../../widgets/snackbar.dart';

class NewHabitScreen extends StatefulWidget {
  // List<Habit> habitsList = [];
  NewHabitScreen({
    super.key,
  });

  @override
  State<NewHabitScreen> createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  late String title;
  String? description;
  int repeat = 1;
  IconData _icon = Icons.check_circle_rounded;
  final habitsController = Get.put(HabitsController());

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  _pickIcon() async {
    IconData? icon =
        await FlutterIconPicker.showIconPicker(context, iconPackModes: [
      IconPack.material,
    ]);

    _icon = icon!;
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
          backgroundColor: AppColors.bg2,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('New habit',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGrey)),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(FontAwesomeIcons.angleLeft,
                      color: AppColors.darkGrey))),
          body: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/habits/addhabit.png'),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _pickIcon();
                                },
                                // ignore: prefer_if_null_operators
                                child: _icon != null
                                    ? Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.darkGrey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(_icon,
                                                size: 50,
                                                color: AppColors.orange2)))
                                    : Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.darkGrey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Icon(
                                              Icons.check_circle_rounded,
                                              size: 60,
                                              color: AppColors.orange2),
                                        )),
                              ),
                              const Text('Choose icon',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkGrey))
                            ],
                          ),
                        ),
                        const Text('Details',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 15),
                        const Text('Title',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w300)),
                        TextFormField(
                          maxLines: 1,
                          maxLength: 22,
                          style: const TextStyle(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                          decoration: const InputDecoration(
                              hintText: 'Go to the gym',
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter a title for the habit.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        const Text('Description',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w300)),
                        TextFormField(
                          maxLines: 2,
                          maxLength: 100,
                          style: const TextStyle(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                          decoration: const InputDecoration(
                              hintText: 'Description',
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.darkGrey, width: 1),
                              )),
                          onChanged: (value) {
                            description = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red[400],
                                ),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        if (repeat == 1) {
                                          MyMessageHandler.showSnackBar(
                                              _scaffoldKey,
                                              'Cannot decrease less than 1.');
                                        } else if (repeat >= 1) {
                                          repeat--;
                                        }
                                      });
                                    },
                                    icon: const Icon(FeatherIcons.minus,
                                        color: Colors.white, size: 20))),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17.0),
                              child: Column(
                                children: [
                                  Text(
                                    '$repeat',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Time a day',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green[400],
                                ),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        repeat++;
                                      });
                                    },
                                    icon: const Icon(FeatherIcons.plus,
                                        color: Colors.white, size: 20))),
                          ],
                        ),
                        const SizedBox(height: 75),
                        Align(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: AppColors.orange2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                HabitsController().addHabit(
                                    content: title,
                                    description: description,
                                    repeat: repeat,
                                    completedCount: 0,
                                    isCompleted: false,
                                    icon: _icon,
                                    timeAdded: Timestamp.now(),);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.0, vertical: 5),
                                child: Text('Save habit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30)),
                              )),
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
