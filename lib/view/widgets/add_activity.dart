import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controller/activity_controller.dart';

class AddActivityDialog extends StatelessWidget {
  AddActivityDialog({super.key});

  final activitiesController = Get.put(ActivitiesController());

  final TextEditingController _activityNameController = TextEditingController();

  final FixedExtentScrollController _wheelMinuteController =
      FixedExtentScrollController();
  final FixedExtentScrollController _wheelHourController =
      FixedExtentScrollController();

  static final _formKey = GlobalKey<FormState>();

  // text style variables
  var whiteTextStyle = const TextStyle(color: AppColors.orange2, fontWeight: FontWeight.w600, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height is half of the screen height
      height: MediaQuery.of(context).size.height / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(
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
                      Text('Add Activity',
                          style: TextStyle(
                              fontSize: 22,
                              color: AppColors.orange2,
                              fontWeight: FontWeight.w500)),
                      //make a circular button with a x icon
                      ElevatedButton(
                        
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(FeatherIcons.x, color: Colors.grey[700]),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: CircleBorder(),
                         // padding: EdgeInsets.all(20),
                          backgroundColor: Colors.grey[350],
                        ),
                      )
                    ],
                  ),
                ),
               const Divider(thickness:2, height:15),
               const SizedBox(height: 15),
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Title', style: TextStyle(color: AppColors.orange2, fontSize: 22, fontWeight: FontWeight.w500)),
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
                        hintText: 'Enter activity...',
                        errorStyle: TextStyle(color: Colors.red, fontSize: 14),
                        hintStyle:
                            TextStyle(color: AppColors.darkGrey.withOpacity(0.5)),
                        enabledBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.darkGrey.withOpacity(0.5)),
                        ),
                        border:  UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                  ),
                ),
                
                   Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  color: AppColors.orange2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
