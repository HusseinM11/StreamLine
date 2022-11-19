import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
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
              value: taskCompleted,
              onChanged: onChanged,
              checkColor: Colors.white,
              activeColor: Color(0xFFFF6E50),
              side: BorderSide(width: 0.6, color: Color(0xFFFF6E50))),
          Text(taskName,
              style: TextStyle(
                  fontSize: 18,
                  decoration:
                      taskCompleted ? TextDecoration.lineThrough : null)),
        ],
      ),
    );
  }
}
