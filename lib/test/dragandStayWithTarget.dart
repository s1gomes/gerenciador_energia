import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeButton.dart';

enum ImagensEletrodomesticos {
  caixaEletronico(
      "Caixa Eletrônico", "assets/images/eletrodomesticos/caixaEletronico.jpg"),
  geladeira("Geladeira", "assets/images/eletrodomesticos/geladeira.jpg"),
  liquidificador(
      "Liquidificador", "assets/images/eletrodomesticos/liquidificador.jpg"),
  maquinaLavar(
      "Máquina de lavar", "assets/images/eletrodomesticos/maquinaLavar.jpg"),
  microondas("Microondas", "assets/images/eletrodomesticos/microondas.jpg"),
  ventilador("Ventilador", "assets/images/eletrodomesticos/ventilador.jpg");

  const ImagensEletrodomesticos(this.label, this.url);
  final String label;
  final String url;
}

enum ImagensComodos {
  cozinha("Cozinha", "assets/images/cozinha.jpg"),
  mesaCadeiraPreta("Sala de jantar", "assets/images/mesa_cadeira_preta.jpg"),
  mesaJanela("Varanda", "assets/images/mesa_com_janela.jpg"),
  plantaCasa("Planta da Casa", "assets/images/planta.jpeg"),
  sala("Sala", "assets/images/sala.jpg");

  const ImagensComodos(this.label, this.url);
  final String label;
  final String url;
}

class DragStayTargetTest extends StatefulWidget {
  const DragStayTargetTest({super.key});

  @override
  State<DragStayTargetTest> createState() => _DragStayTargetTestState();
}

class _DragStayTargetTestState extends State<DragStayTargetTest> {
  Offset position = Offset(100, 100);
  List<Widget> containerCor = [];
  void updatePosition(Offset newPosition) => setState(() {
        position = newPosition;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // por hora fixo, a ideia seria receber a imagem selecionada do botão de gerenciar
                            image: DecorationImage(
                                image: AssetImage(
                                  ImagensComodos.cozinha.url.toString(),
                                ),
                                fit: BoxFit.fill,
                                opacity: 23),
                            color: const Color.fromARGB(255, 215, 210, 210),
                            border: Border.all(color: Colors.black)),
                        height: 300,
                        width: double.infinity,
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
                            return Container(
                              // maxRadius: 12,
                              height: 50,
                              width: 25,
                              // radius: 12,

                              child: containerCor[index],
                            );
                            // return containerCor[index];
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
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

            SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ImagensEletrodomesticos.values.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Draggable<Widget>(
                      maxSimultaneousDrags: 1,
                      // onDragEnd: (details) => updatePosition(details.offset),
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
                        child: Image.asset(
                            ImagensEletrodomesticos.values[index].url.toString()),
                      ),
                      // ImagensEletrodomesticos.values.map<ImagensEletrodomesticos>((ImagensEletrodomesticos image ) {
                      //                     return Image.asset(ImagensEletrodomesticos.url);
                      // }).toString();
                      // o que aparece sendo arrastado
                      feedback: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImagensEletrodomesticos.values[index].url.toString(),
                            ),
                          ),
                        ),
                      ),

                      // aparece no ludar do objeto inicial enquando feedback está sendo arrastado
                      childWhenDragging: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImagensEletrodomesticos.values[index].url.toString(),
                            ),
                            opacity: 1,
                          ),
                        ),
                      ),
                      // objeto inicial
                      child: Container(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                              ImagensEletrodomesticos.values[index].url.toString())),
                    ),
                  );
                },
              ),
            ),

            // Positioned.fill(
            //     child: Container(
            //   color: Colors.amber.withOpacity(.4),
            // )),
          ],
        ),
      ),
    );
  }
}
