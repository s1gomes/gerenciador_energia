import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton(
      {super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(label),
          )
        : TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color.fromARGB(255, 221, 218, 218)),
            ),
            onPressed: onPressed,
            child: Text(label, style: const TextStyle(fontSize: 17)));
  }
}
