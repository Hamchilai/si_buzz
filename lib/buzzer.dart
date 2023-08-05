import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Buzzer {
  void turnLed(bool on);
}

class BuzzerWidget extends StatefulWidget {
  const BuzzerWidget({super.key, required this.index, required this.buzzer});

  final int index;
  final Buzzer buzzer;
  @override
  State<BuzzerWidget> createState() => _BuzzerWidgetState();

  void setPressed(bool pressed) {
  }
}

class _BuzzerWidgetState extends State<BuzzerWidget> implements Buzzer {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Player ${widget.index + 1}: ${pressed}')
    );
  }

  @override
  void turnLed(bool on) {
    // TODO: implement turnLed
  }
}