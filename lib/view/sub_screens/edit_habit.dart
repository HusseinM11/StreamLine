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

import '../../constants/colors.dart';
import '../../controller/habits_controller.dart';
import '../../widgets/buttons.dart';
import '../../widgets/snackbar.dart';

class EditHabitScreen extends StatefulWidget {
  final int index;
  final scaffoldkey;
  EditHabitScreen({super.key, required this.index, required this.scaffoldkey});

  @override
  State<EditHabitScreen> createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<EditHabitScreen> {
  final habitsController = Get.put(HabitsController());
  IconData _icon = Icons.check_circle_rounded;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _icon = habitsController.habits[widget.index].icon;
  }

  _pickIcon() async {
    IconData? icon =
        await FlutterIconPicker.showIconPicker(context, iconPackModes: [
      IconPack.material,
    ]);

    _icon = icon!;
    setState(() {});
  }
  // get the selected priority from the habits list inside the habits get controller
  

  late int repeat = habitsController.habits[widget.index].repeatDaily;

  @override
  Widget build(BuildContext context) {
    String _priority = habitsController.habits[widget.index].priority;
    String content = habitsController.habits[widget.index].content;
    String? description = habitsController.habits[widget.index].description;
    TextEditingController titleController =
        TextEditingController(text: content);
    TextEditingController descController =
        TextEditingController(text: description);
    //_icon = habitsController.habits[widget.index].icon;
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
                            content = value;
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
                        Align(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: CupertinoSegmentedControl<String>(
                              //style the segmented control buttons
                              selectedColor: AppColors.orange2,
                              unselectedColor:
                                  AppColors.darkGrey.withOpacity(0.3),
                              borderColor: Colors.transparent,
                              pressedColor: AppColors.orange2,

                              children: const {
                                'High': Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Text('High',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                                'Medium': Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Text('Medium',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                                'Low': Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Text('Low',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                              },
                              onValueChanged: (String newValue) {
                                setState(() {
                                  _priority = newValue;
                                });
                              },
                              groupValue: _priority,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        RepeatSetter(
                          repeat: repeat,
                          scaffoldKey: _scaffoldKey,
                          callback: (p0) {
                            repeat = p0;
                          },
                        ),
                        const SizedBox(height: 75),
                        Align(
                          child: RoundedTextButton(
                              label: 'Save Changes',
                              onPressed: () {
                                //editHabit(title, description, repeat, _icon);
                                habitsController.updateHabit(
                                    content: content,
                                    description: description,
                                    habitId: habitsController
                                        .habits[widget.index].habitId,
                                    icon: _icon,
                                    repeat: repeat,
                                    uid: habitsController.uid,
                                    completedCount: habitsController
                                        .habits[widget.index].completedCount,
                                        priority: _priority);
                                Get.back();
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
                      backgroundColor: AppColors.orange,
                      onPressed: () {
                        habitsController.deleteHabit(habitsController.uid,
                            habitsController.habits[widget.index].habitId);
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

class RepeatSetter extends StatefulWidget {
  final Function(int) callback;
  RepeatSetter({
    Key? key,
    required this.callback,
    required this.repeat,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  int repeat;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey;

  @override
  State<RepeatSetter> createState() => _RepeatSetterState();
}

class _RepeatSetterState extends State<RepeatSetter> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                  if (widget.repeat == 1) {
                    MyMessageHandler.showSnackBar(
                        widget._scaffoldKey, 'Cannot decrease less than 1.');
                  } else if (widget.repeat >= 1) {
                    setState(() {
                      widget.repeat--;
                      widget.callback(widget.repeat);
                    });
                  }
                },
                icon: const Icon(FeatherIcons.minus,
                    color: Colors.white, size: 20))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            children: [
              Text(
                widget.repeat.toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Time a day',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
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
                    widget.repeat++;
                    widget.callback(widget.repeat);
                  });
                },
                icon: const Icon(FeatherIcons.plus,
                    color: Colors.white, size: 20))),
      ],
    );
  }
}
