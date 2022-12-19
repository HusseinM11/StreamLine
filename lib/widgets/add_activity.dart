import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/activity_controller.dart';

class AddActivityDialog extends StatelessWidget {
   AddActivityDialog({super.key});

   final activitiesController = Get.put(ActivitiesController());

    TextEditingController _activityNameController = TextEditingController();

    FixedExtentScrollController _wheelMinuteController = FixedExtentScrollController();

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
          style: TextStyle(fontSize: 22, color: Color(0xFFFF6E50), fontWeight: FontWeight.w500)),
          SizedBox(height: 15),
                    TextField(
                      controller: _activityNameController,
                      style: whiteTextStyle,
                      maxLength: 16,
                      decoration: InputDecoration(
                        hintText: 'Enter activity...',
                        hintStyle: TextStyle(
                            color: AppColors.darkGrey.withOpacity(0.5)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.orange),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      elevation: 0,
                      onPressed: () {
                         activitiesController.addActivity(
                            content: _activityNameController.text,
                            timeGoal: _wheelMinuteController.selectedItem,     
                            ); 
                             Get.back();
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