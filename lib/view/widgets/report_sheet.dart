import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/colors.dart';
import 'package:streamline/controller/users_controller.dart';
import 'package:streamline/view/widgets/send_email.dart';

import '../../controller/auth_controller.dart';

class ReportSheet extends StatelessWidget {
  ReportSheet({super.key});
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final AuthController authController = Get.find();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.25,
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
                      const Text('Report a Bug',
                          style: TextStyle(
                              fontSize: 22,
                              color: AppColors.orange2,
                              fontWeight: FontWeight.w500)),
                      //make a circular button with a x icon
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          controller.clear();
                        },
                        child: Icon(FeatherIcons.x, color: Colors.grey[700]),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const CircleBorder(),
                          // padding: EdgeInsets.all(20),
                          backgroundColor: Colors.grey[350],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(thickness: 2, height: 15),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Issue',
                      style: TextStyle(
                          color: AppColors.orange2,
                          fontSize: 22,
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                        maxLines: 5,
                        maxLength: 350,
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Describe the issue here...',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.3),
                                  width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.3),
                                  width: 1)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.darkGrey.withOpacity(0.3),
                                  width: 1)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please describe the issue.';
                          } else {
                            return null;
                          }
                        }),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await sendEmail(
                          'Hussein', controller.value.text, 'elyarose@gmail.com');
                      if (response == 200) {
                        Get.snackbar('Success', 'Your report has been sent.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                      } else {
                        //print error message of the request
                        //print error message of the request
                        // specific error message for 403
                        print(response);
                      }
                      controller.clear();
                      Get.back();
                    } else {
                      return null;
                    }
                  },
                  color: AppColors.orange2,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
//delete a cloud function firebase
// in terminal
// firebase functions:delete deleteReport