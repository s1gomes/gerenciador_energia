import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class adaptativeTextField extends StatelessWidget {
  const adaptativeTextField({super.key, required this.controller, required this.label, required this.keyboardType});
  final TextEditingController controller;
  final TextInputType keyboardType;
  // final Function(String) onSubmitted;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0),
      child: CupertinoTextField(
      controller: controller,
      keyboardType: keyboardType,
      // onSubmitted: onSubmitted,
      placeholder: label,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 12
      ),
      ),
    )
    :
    TextField(
    controller: controller,
    keyboardType: keyboardType,
    // onSubmitted: onSubmitted,
    decoration: InputDecoration(labelText: label)
    );
  }
}