import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:taskmum_flutter/components/clock/clock_analog_widget.dart';

class TickerBuilder extends StatefulWidget {
  @override
  _TickerBuilderState createState() => _TickerBuilderState();
}

class _TickerBuilderState extends State<TickerBuilder>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late DateTime _time;

  @override
  void initState() {
    super.initState();
    _time = DateTime.now();
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = DateTime.now();
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnalogClockRenderer(time: _time);
  }
}