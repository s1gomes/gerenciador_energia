import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeButton.dart';

class DraggableTest extends StatefulWidget {
  const DraggableTest({super.key});

  @override
  State<DraggableTest> createState() => _DraggableTestState();
}

class _DraggableTestState extends State<DraggableTest> {
    Offset position = Offset(100, 100);

  void updatePosition(Offset newPosition) => setState(() {
        position = newPosition;
      });
  Color corRecebida = Colors.black;
  List<Widget> containerCor = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            DragTarget<Widget>(
              onAcceptWithDetails: (details) {
                setState(() {
                  // List.add(details.data);
                  containerCor.add(details.data);
                  // corRecebida = details.data;
                });
              },
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Column(
                  children: [
                    
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 215, 210, 210),
                          border: Border.all(color: Colors.black)),
                      height: 400,
                      width: 300,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          mainAxisExtent: 50,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: containerCor.length,
                        itemBuilder: (context, index) {
                          return CircleAvatar(
                            maxRadius: 12,
                            
                            // radius: 12,

                            child: containerCor[index],
                          );
                          // return containerCor[index];
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AdaptativeButton(
                        label: "limpar",
                        onPressed: () {
                          setState(() {
                            containerCor.removeLast();
                          });
                        })
                  ],
                );
              },
            ),
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
              data: Container(
                height: 50,
                width: 50,
                color: Color.fromARGB(255, 152, 68, 68),
              ),

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
      ),
    );
  }
}
