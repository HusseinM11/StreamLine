import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamline/widgets/dialog_button.dart';

import '../controller/todo_controller.dart';

class DialogBox extends StatelessWidget {
  final controller;
  Function() onAdd;
  Function() onCancel;
   DialogBox({super.key, required this.controller, required this.onCancel, required this.onAdd});
  final todosController = Get.put(TodosController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Todo:',
          style: TextStyle(fontSize: 20, color: Color(0xFFFF6E50))),
      backgroundColor: Colors.white, // Color(0xFFFF6E50),
      content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Read new book',
                      border: UnderlineInputBorder())),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                      label: 'Add', onPressed: onAdd, color: Colors.green),
                  SizedBox(width: 5),
                  DialogButton(
                      label: 'Cancel', onPressed: onCancel, color: Colors.red),
                ],
              ),
            ],
          )),
    );
  }
}
