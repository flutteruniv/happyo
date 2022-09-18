import 'package:flutter/material.dart';

class EventFormLabel extends StatelessWidget {
  String label;

  EventFormLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
