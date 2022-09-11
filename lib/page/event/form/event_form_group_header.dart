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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
