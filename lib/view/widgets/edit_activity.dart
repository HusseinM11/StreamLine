/* import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/activity_controller.dart';

class EditActivityDialog extends StatelessWidget {
  int index;
  EditActivityDialog({super.key, required this.index});

  final activitiesController = Get.put(ActivitiesController());

  // text style variables
  var whiteTextStyle = const TextStyle(color: AppColors.darkGrey);

  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController _wheelMinuteController =
        FixedExtentScrollController(
            initialItem: activitiesController.activities[index].timeGoal);
    TextEditingController _activityNameController = TextEditingController(
        text: activitiesController.activities[index].content);

    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Edit Activity:',
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFFFF6E50),
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 15),
                TextField(
                  controller: _activityNameController,
                  style: whiteTextStyle,
                  maxLength: 12,
                  decoration: InputDecoration(
                    hintText: activitiesController.activities[index].content,
                    hintStyle:
                        TextStyle(color: AppColors.darkGrey.withOpacity(0.5)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.orange),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Daily goal time for this habit',
                  style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Container(
                      alignment: const Alignment(0, 0),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.darkGrey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // scroll wheel for hours
                        /* Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: SizedBox(
                                width: 50,
                                child: ListWheelScrollView.useDelegate(
                                  itemExtent: 30,
                                  perspective: 0.005,
                                  diameterRatio: 1.2,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 24,
                                    builder: (context, index) {
                                      return Text(
                                        index.toString(),
                                        style: const TextStyle(
                                          color: AppColors.darkGrey,
                                          fontSize: 20,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ), */

                        // hour

                        // scroll wheel for minutes
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: SizedBox(
                            width: 50,
                            child: ListWheelScrollView.useDelegate(
                              controller: _wheelMinuteController,
                              itemExtent: 30,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 120,
                                builder: (context, index) {
                                  return Text(
                                    index.toString(),
                                    style: const TextStyle(
                                      color: AppColors.darkGrey,
                                      fontSize: 20,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        // mins
                        Text(
                          'mins',
                          style: whiteTextStyle,
                        ),
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: 
                  
                  BoxDecoration(shape: BoxShape.circle, color: AppColors.orange,),
                  
                  child: IconButton(
                      padding: EdgeInsets.all(6),
                      constraints: BoxConstraints(),
                      onPressed: () => activitiesController.deleteActivity(
                          uid: activitiesController.uid,
                          actvId:
                              activitiesController.activities[index].actvId),
                      icon: Icon(FeatherIcons.trash,
                          color: Colors.white, size: 20)),
                ),
                SizedBox(width:10),
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    activitiesController.updateActivity(
                        content: _activityNameController.text,
                        uid: activitiesController.uid,
                        actvId: activitiesController.activities[index].actvId,
                        timeGoal: _wheelMinuteController.selectedItem);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: AppColors.orange,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controller/activity_controller.dart';

class EditActivityDialog extends StatelessWidget {
  int index;
  EditActivityDialog({super.key, required this.index});

  final activitiesController = Get.put(ActivitiesController(firestore: FirebaseFirestore.instance));

  // make a final form global key
  static final _formKey = GlobalKey<FormState>();
  // text style variables
  var whiteTextStyle = const TextStyle(color: AppColors.darkGrey);
  // convert minutes to hours
  int convertMinutesToHours(int minutes) {
    if (minutes >= 60) {
      return minutes ~/ 60;
    } else {
      return 0;
    }
  }

  int acceptMinutes(int minutes) {
    if (minutes % 60 != 0) {
      return minutes;
    } else {
      
          return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    int timeInMinutes = activitiesController.activities[index].timeGoal % 60 ;
    int timeInHours = activitiesController.activities[index].timeGoal ~/ 60;
    FixedExtentScrollController _wheelMinuteController =
        FixedExtentScrollController(
            initialItem: timeInMinutes);
    FixedExtentScrollController _wheelHourController =
        FixedExtentScrollController(
            initialItem: timeInHours);
    TextEditingController _activityNameController = TextEditingController(
        text: activitiesController.activities[index].content);
    return SizedBox(
      // height is half of the screen height
      height: MediaQuery.of(context).size.height / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(
              height: 0,
              thickness: 5,
              indent: 165,
              endIndent: 165,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Edit Activity',
                          style: TextStyle(
                              fontSize: 22,
                              color: AppColors.orange2,
                              fontWeight: FontWeight.w500)),
                      //make a circular button with a x icon
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:  () => activitiesController.deleteActivity(
                          uid: activitiesController.uid,
                          actvId:
                              activitiesController.activities[index].actvId),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: const CircleBorder(),
                              
                              backgroundColor: Colors.grey[350],
                            ),
                            child: Icon(FeatherIcons.trash, color: Colors.grey[700], size: 22),
                          ),
                          ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const CircleBorder(),
                          
                          backgroundColor: Colors.grey[350],
                        ),
                        child: Icon(FeatherIcons.x, color: Colors.grey[700]),
                      ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
                const Divider(thickness: 2, height: 15),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Title',
                      style: TextStyle(
                          color: AppColors.orange2,
                          fontSize: 22,
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an activity name.';
                        } else {
                          return null;
                        }
                      },
                      controller: _activityNameController,
                      //style: whiteTextStyle,
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText:
                            activitiesController.activities[index].content,
                        errorStyle: const TextStyle(color: Colors.red, fontSize: 14),
                        hintStyle: TextStyle(
                            color: AppColors.darkGrey.withOpacity(0.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.darkGrey.withOpacity(0.5)),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Daily goal time',
                    style: TextStyle(
                        color: AppColors.orange2,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // scroll wheel for hours
                        Text(
                          'hrs',
                          style: whiteTextStyle,
                        ),
                        SizedBox(
                          width: 40,
                          child: ListWheelScrollView.useDelegate(
                            controller: _wheelHourController,
                            itemExtent: 30,
                            perspective: 0.005,
                            diameterRatio: 1,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 24,
                              builder: (context, index) {
                                return Text(
                                  index.toString(),
                                  style: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // hour

                        // scroll wheel for minutes
                        SizedBox(
                          width: 40,
                          child: ListWheelScrollView.useDelegate(
                            controller: _wheelMinuteController,
                            itemExtent: 30,
                            perspective: 0.005,
                            diameterRatio: 1,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 60,
                              builder: (context, index) {
                                return Text(
                                  index.toString(),
                                  style: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // mins
                        Text(
                          'mins',
                          style: whiteTextStyle,
                        ),
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        (_wheelMinuteController.selectedItem != 0 ||
                            _wheelHourController.selectedItem != 0)) {
                      activitiesController.addActivity(
                        content: _activityNameController.text,
                        timeGoal: _wheelMinuteController.selectedItem +
                            (_wheelHourController.selectedItem * 60),
                      );
                      Get.back();
                    } else {
                      Get.snackbar('Error',
                          'Please choose the goal time for this habit.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.darkGrey.withOpacity(0.7),
                          colorText: Colors.white);
                    }
                  },
                  color: AppColors.orange2,
                  child: const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
