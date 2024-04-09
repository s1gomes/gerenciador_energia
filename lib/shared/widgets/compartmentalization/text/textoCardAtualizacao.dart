import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextSemCadastros extends StatelessWidget {
  const TextSemCadastros({super.key, required this.frase});
  final String frase;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: double.infinity,
        child: Padding(
          padding:  const EdgeInsets.all(8.0),
          child: Text(
            frase,
            style: const TextStyle(
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
