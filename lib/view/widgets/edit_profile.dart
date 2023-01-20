import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:streamline/constants/colors.dart';
import 'package:streamline/controller/users_controller.dart';
import 'package:streamline/view/widgets/auth_widgets.dart';
import 'package:streamline/view/widgets/send_email.dart';

import '../../controller/auth_controller.dart';

class EditProfileSheet extends StatefulWidget {
  EditProfileSheet({super.key});
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final AuthController authController = Get.find();

  
  bool _isEditing = false;
  //get the name of the user from the user controller and set it to the text field
  TextEditingController nameController = TextEditingController(
    text: Get.find<UserController>().user.name,
  );
  //get the email of the user from the user controller and set it to the text field
  TextEditingController emailController = TextEditingController(
    text: Get.find<UserController>().user.email,
  );
 UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      const Text('Edit Profile',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Name',
                            style: TextStyle(
                                color: AppColors.orange2,
                                fontSize: 22,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: nameController,
                                enabled: _isEditing,
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      color: AppColors.orange, fontSize: 13),
                                  hintText: 'Enter a new name',
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.3),
                                          width: 1)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.3),
                                          width: 1)),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.3),
                                          width: 1)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter a name.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(_isEditing ? Icons.check : Icons.edit),
                              onPressed: () {
                                setState(() {
                                  _isEditing = !_isEditing;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text('Email',
                            style: TextStyle(
                                color: AppColors.orange2,
                                fontSize: 22,
                                fontWeight: FontWeight.w500)),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: emailController,
                                enabled: _isEditing,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your email ';
                                  } else if (value.isValidEmail() == false) {
                                    return 'invalid email';
                                  } else if (value.isValidEmail() == true) {
                                    return null;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      color: AppColors.orange, fontSize: 13),
                                  hintText: 'Enter email',
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.3),
                                          width: 1)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.3),
                                          width: 1)),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.3),
                                          width: 1)),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(_isEditing ? Icons.check : Icons.edit),
                              onPressed: () {
                                setState(() {
                                  _isEditing = !_isEditing;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                    //validate the form and update the user
                    if (_formState.currentState!.validate()) {
                      await userController
                          .updateName(nameController.text);
                      await userController
                          .updateEmail(emailController.text);
                      //snackbar to show that the user has been updated
                      Get.back();
                      Get.snackbar('Success', 'Details updated',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.darkGrey.withOpacity(0.7),
                          colorText: Colors.white);
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
