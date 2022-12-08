import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/FontAwesome.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:streamline/model/habit.dart';

import 'package:streamline/main_screens/habits.dart';

import '../constants/colors.dart';
import '../controller/habits_controller.dart';
import '../widgets/snackbar.dart';

class EditHabitScreen extends StatefulWidget {
  final int index;
  final scaffoldkey;
  EditHabitScreen({super.key, required this.index, required this.scaffoldkey});

  @override
  State<EditHabitScreen> createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<EditHabitScreen> {
  IconData _icon = CupertinoIcons.arrowtriangle_down_square;
  final habitsController = Get.put(HabitsController());

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  _pickIcon() async {
    IconData? icon =
        await FlutterIconPicker.showIconPicker(context, iconPackModes: [
      IconPack.cupertino,
    ]);

    _icon = icon!;
    setState(() {});
  }

  late int repeat = habitsController.habits[widget.index].repeatDaily;

  void editHabit(
      String habitName, String? description, int repeat, IconData icon) {
    habitsController.habits[widget.index].habitName = habitName;
    habitsController.habits[widget.index].description = description;
    habitsController.habits[widget.index].repeatDaily = repeat;
    habitsController.habits[widget.index].icon = icon;
    habitsController.update();
    Get.back();
  }

  /* void increaseRepeat() {
    habitsController.habits[widget.index].repeatDaily++;
    habitsController.update();
  }

  void decreaseRepeat() {
    habitsController.habits[widget.index].repeatDaily--;
    habitsController.update();
  } */

  @override
  Widget build(BuildContext context) {
    String title = habitsController.habits[widget.index].habitName;
    String? description = habitsController.habits[widget.index].description;
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController descController =
        TextEditingController(text: description);
    _icon = habitsController.habits[widget.index].icon;
    int repeatDaily = habitsController.habits[widget.index].repeatDaily;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
          backgroundColor: AppColors.bg2,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Edit habit',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGrey)),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
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
                                              CupertinoIcons
                                                  .arrowtriangle_down_square,
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
                          controller: titleController,
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
                          controller: descController,
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
                                      if (repeat == 1) {
                                        MyMessageHandler.showSnackBar(
                                            _scaffoldKey,
                                            'Cannot decrease less than 1.');
                                      } else if (repeat >= 1) {
                                        repeat--;
                                        habitsController.setRepeat(
                                            widget.index, repeat);

                                        debugPrint(
                                            '${habitsController.habits[widget.index].repeatDaily}');
                                      }
                                    },
                                    icon: const Icon(FeatherIcons.minus,
                                        color: Colors.white, size: 20))),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17.0),
                              child: Column(
                                children: [
                                  GetBuilder<HabitsController>(
                                    builder: (controller) {
                                      return Text(
                                        controller
                                            .habits[widget.index].repeatDaily
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600),
                                      );
                                    },
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
                                      repeat++;
                                      habitsController.setRepeat(
                                          widget.index, repeat);
                                      habitsController.update();

                                      debugPrint(
                                          '${habitsController.habits[widget.index].repeatDaily}');
                                    },
                                    icon: const Icon(FeatherIcons.plus,
                                        color: Colors.white, size: 20))),
                          ],
                        ),
                        const SizedBox(height: 75),
                        Align(
                          child: RoundedTextButton(
                              label: 'Save Changes',
                              onPressed: () {
                                editHabit(title, description, repeat, _icon);
                              }),
                        ),
                      ],
                    ),
                  )),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () {
                        habitsController.deleteHabit(widget.index);
                        Get.back();
                      },
                      elevation: 0,
                      child: Icon(FontAwesomeIcons.trash, size: 25)),
                ),
              )
            ],
          )),
    );
  }
}

class RoundedTextButton extends StatelessWidget {
  String label;
  Function() onPressed;
  RoundedTextButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: AppColors.orange2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30)),
        ));
  }
}
