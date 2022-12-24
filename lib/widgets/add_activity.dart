import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/activity_controller.dart';

class AddActivityDialog extends StatelessWidget {
  AddActivityDialog({super.key});

  final activitiesController = Get.put(ActivitiesController());

  final TextEditingController _activityNameController = TextEditingController();

  final FixedExtentScrollController _wheelMinuteController =
      FixedExtentScrollController();
  final FixedExtentScrollController _wheelHourController =
      FixedExtentScrollController();
  
  final  _formKey = GlobalKey<FormState>();

  // text style variables
  var whiteTextStyle = const TextStyle(color: AppColors.darkGrey);
  
  @override
  Widget build(BuildContext context) {
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
                Text('Add New Activity:',
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFFFF6E50),
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 15),
                Form(
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
                    style: whiteTextStyle,
                    maxLength: 12,
                    decoration: InputDecoration(
                      hintText: 'Enter activity...',
                      errorStyle: TextStyle(color: Colors.red, fontSize: 14),
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
                ),
                const SizedBox(height: 25),
                Text(
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
                        Text(
                              'hrs',
                              style: whiteTextStyle,
                            ),
                        Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: SizedBox(
                                width: 50,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _wheelHourController,
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
                            ),

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    if (_formKey.currentState!.validate() && (_wheelMinuteController.selectedItem != 0 || _wheelHourController.selectedItem != 0) ) {
                      activitiesController.addActivity(
                        content: _activityNameController.text,
                        timeGoal: _wheelMinuteController.selectedItem + (_wheelHourController.selectedItem * 60),
                      );
                      Get.back();
                    } else {
                      Get.snackbar('Error', 'Please choose the goal time for this habit.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.darkGrey.withOpacity(0.7),
            colorText: Colors.white);
                    }
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
