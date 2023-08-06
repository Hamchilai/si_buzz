import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuzzersWrapper {
  BuzzersWrapper({required this.callback});
  void reset() {
    _setPressedBuzzers([]);
  }

  // Return a list of pressed buzzers in the order of them being pressed. At the
  // moment the size is at most 1.
  List<int> get pressedBuzzers {
    assert(_pressedBuzzers.length <= 1);
    return _pressedBuzzers;
  }

  void _setPressedBuzzers(List<int> newList) {
    if (newList == _pressedBuzzers) {
      return;
    }
    _pressedBuzzers = newList;
    callback();
  }

  void pressOnForDebug(int index) {
    assert(isDebug);
    if (pressedBuzzers.isNotEmpty) {
      return;
    }
    _setPressedBuzzers([index]);
  }

  final VoidCallback callback;
  bool isDebug = true;
  List<int> _pressedBuzzers = [];
}

abstract class Buzzer {
  void turnLed(bool on);
}

class BuzzerWidget extends StatefulWidget {
  const BuzzerWidget({super.key, required this.index, required this.buzzer});

  final int index;
  final Buzzer buzzer;
  @override
  State<BuzzerWidget> createState() => _BuzzerWidgetState();

  void setPressed(bool pressed) {}
}

class _BuzzerWidgetState extends State<BuzzerWidget> implements Buzzer {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('Player ${widget.index + 1}: ${pressed}'));
  }

  @override
  void turnLed(bool on) {
    // TODO: implement turnLed
  }
}
