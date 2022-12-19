import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';
import '../model/todo.dart';

class TodoTile extends StatelessWidget {
  final String uid;
  final TodoModel todo;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile(
      {super.key,
      required this.uid,
      required this.todo,
      required this.onChanged,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
            onPressed: deleteFunction,
            icon: FeatherIcons.delete,
            backgroundColor: Colors.red),
      ]),
      child: Row(
        children: [
          Checkbox(
              value: todo.isCompleted,
              onChanged: onChanged,
              checkColor: Colors.white,
              activeColor: Color(0xFFFF6E50),
              side: BorderSide(width: 0.6, color: Color(0xFFFF6E50))),
          Text(todo.content,
              style: TextStyle(
                  fontSize: 18,
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null)),
        ],
      ),
    );
  }
}

// todosController.deleteTodo(uid, todo.todoId);