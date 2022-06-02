import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:askMu/components/models/task_data.dart';

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
        const SizedBox(height: 13),
        Text(
          data.title,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "小節番号 $measureString",
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          color: Colors.grey,)
      ],
    );
  }

  Widget rightArea() {
    final createAt = DateFormat("yyyy/MM/dd").format(data.createAt);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          createAt,
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
