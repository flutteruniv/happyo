import 'package:flutter/material.dart';

class EventFormGroupHeader extends StatelessWidget {
  String text;

  EventFormGroupHeader(
    this.text, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
