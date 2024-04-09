import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TextCardContainer extends StatelessWidget {
  TextCardContainer(
      {super.key,
      required this.constraints,
      required this.titleController,
      this.functionOnpressed,
      this.iconData});
  final BoxConstraints constraints;
  final String titleController;
  VoidCallback? functionOnpressed;
  IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: constraints.maxWidth * 0.09,
        ),
        Container(
            // height: constraints.maxHeight * 0.05,
            width: constraints.maxWidth * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                titleController,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            )),
        
          Container(
            height: 50,
            width: 50,
            child: IconButton(
              onPressed: functionOnpressed,
              icon: Icon(iconData),
            ),
          )
        
      ],
    );
  }
}
