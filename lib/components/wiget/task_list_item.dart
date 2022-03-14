import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';

class TaskListItem extends StatelessWidget{
  const TaskListItem({
    required this.data,
    required this.onPress,
    required this.width,
    required this.height,
  });

  final TaskData data;

  final void Function(TaskData data) onPress;

  final double width;

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          leftArea(),
          rightArea(),
          InkWell(
            onTap: () => onPress(data),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          )
        ],
      ),
    );
  }

  Widget leftArea() {
    final measureString = data.measureNum.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          data.title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "小節番号 $measureString",
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          height: 10,
          color: Colors.grey,)
      ],
    );
  }

  Widget rightArea() {
    final createAt = DateFormat("yyyy/MM/dd").format(data.createAt);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          createAt,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Text(
//   data.title,
//   textAlign: TextAlign.start,
//   style: const TextStyle(
//     fontSize: 18,
//     color: Colors.white,
//     fontWeight: FontWeight.bold,
//   ),
// ),
// Text(
//   data.createAt.toString(),
//   textAlign: TextAlign.end,
// ),
// Text(
//   data.comment,
//   textAlign: TextAlign.end,
// ),