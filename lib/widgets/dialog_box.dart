import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:streamline/widgets/dialog_button.dart';

import '../constants/colors.dart';
import '../controller/todo_controller.dart';

class DialogBox extends StatelessWidget {
  final controller;
  Function() onAdd;
  Function() onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onAdd});
  final todosController = Get.put(TodosController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: MediaQuery.of(context).size.height / 2 +
                MediaQuery.of(context).viewInsets.bottom,
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
                      Text('Add Todo',
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
                          shape: CircleBorder(),
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
                        maxLength: 35,
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: 'Read new book',
                            border: UnderlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a todo name.';
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onAdd();
                    } else {
                      return null;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
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
