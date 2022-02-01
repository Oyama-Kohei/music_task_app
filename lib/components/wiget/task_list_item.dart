import 'package:flutter/material.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';

class TaskListItem extends StatelessWidget{
  const TaskListItem({
    required this.data,
    // required this.onPress,
    required this.width,
    required this.height,
  });

  final TaskData data;

  // final void Function(TaskData data) onPress;

  final double width;

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.title,
          textAlign: TextAlign.start,
        ),
        Text(
          data.createAt.toString(),
          textAlign: TextAlign.end,
        ),
        Text(
          data.comment,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}