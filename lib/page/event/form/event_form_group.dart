import 'package:flutter/material.dart';

class EventFormGroup extends StatelessWidget {
  Widget? header;
  List<Widget> children;

  EventFormGroup({
    super.key,
    this.header,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18,
      ),
      child: Column(
        children: [
          if (header != null) header!,
          ...children,
        ],
      ),
    );
  }
}
