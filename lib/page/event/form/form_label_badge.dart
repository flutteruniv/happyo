import 'package:flutter/material.dart';

class FormLabelBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        '必須',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
