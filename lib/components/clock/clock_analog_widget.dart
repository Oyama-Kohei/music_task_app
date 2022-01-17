import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskmum_flutter/components/clock/clock_hand.dart';
import 'package:taskmum_flutter/components/clock/clock_marker.dart';

class AnalogClockRenderer extends StatelessWidget {
  final DateTime time;
  final double radius;
  final Color plateColor;
  final Color dialColor;
  final Color secondColor;
  final Color minuteColor;
  final Color hourColor;

  const AnalogClockRenderer({
    Key? key,
    required this.time,
    this.radius = 120.0,
    this.plateColor = Colors.black,
    this.dialColor = Colors.white,
    this.secondColor = Colors.red,
    this.minuteColor = Colors.grey,
    this.hourColor = Colors.grey,
  }) : super(key: key);

  int get secondsInMillisecond => time.second * 1000 + time.millisecond;
  int get minutesInSecond => time.minute * 60 + time.second;
  int get hoursInMinute => (time.hour % 12) * 60 + time.minute;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = 0; i < 60; i++)
            ClockMarker(
              index: i,
              radius: radius,
              markerWidth: 1,
              markerHeight: 12,
              fontSize: 18,
            ),
          // 秒針
          ClockHand(
            angle: (2 * pi) * (secondsInMillisecond / (60 * 1000)),
            thickness: 1,
            length: 140,
            color: Colors.pink,
          ),
          // 分針
          ClockHand(
            angle: (2 * pi) * (minutesInSecond / (60 * 60)),
            thickness: 6,
            length: 120,
            color: Colors.white70,
            shadowColor: Colors.amber,
          ),
          // 時針
          ClockHand(
            angle: (2 * pi) * (hoursInMinute / (60 * 12)),
            thickness: 8,
            length: 82,
            color: Colors.white70,
            shadowColor: Colors.amber,
          ),
          // const ClockCenterCircle(
          //   size: 27,
          //   color: Colors.amber,
          // ),
        ],
      ),
    );
  }
}