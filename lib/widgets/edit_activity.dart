import 'package:flutter/material.dart';
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
