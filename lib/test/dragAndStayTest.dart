import 'package:flutter/material.dart';

class DragStayTest extends StatefulWidget {
  const DragStayTest({super.key});

  @override
  State<DragStayTest> createState() => _DragStayTestState();
}

class _DragStayTestState extends State<DragStayTest> {
  Offset position = Offset(100, 100);
  List<Widget> containerCor = [];
  void updatePosition(Offset newPosition) => setState(() {
        position = newPosition;
      });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Stack(
        children: [
          
          Positioned.fill(
              child: Container(
            color: Colors.amber.withOpacity(.4),
          )),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable<Widget>(
              maxSimultaneousDrags: 1,
              onDragEnd: (details) => updatePosition(details.offset),
              // data: <Widget>[
              //   Container(
              //     height: 50,
              //     width: 50,
              //     color: Colors.red,
              //   ),
              // ],
              // os dados que vão ser levados
              // data: Container(
              //   height: 50,
              //   width: 50,
              //   color:const Color.fromARGB(255, 152, 68, 68),
              // ),

              // o que aparece sendo arrastado
              feedback: Container(
                height: 50,
                width: 50,
                color: Colors.red,
              ),

              // aparece no ludar do objeto inicial enquando feedback está sendo arrastado
              childWhenDragging: Container(
                height: 50,
                width: 50,
                color: Colors.black,
              ),
              // objeto inicial
              child: Container(
                height: 50,
                width: 50,
                color: Colors.yellow,
              ),
            ),
          )
        ],
      ),
    );
  }
}
