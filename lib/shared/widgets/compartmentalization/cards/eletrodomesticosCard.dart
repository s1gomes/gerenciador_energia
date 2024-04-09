import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EletrodomesticosCard extends StatelessWidget {
  const EletrodomesticosCard({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: constraints.maxHeight * 0.03),
        Container(
          height: constraints.maxHeight * 0.04,
          width: constraints.maxWidth * 0.75,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Eletrodomésticos",
              style: TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
