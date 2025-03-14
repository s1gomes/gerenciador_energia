import 'package:flutter/material.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/pages/home/main_comodos.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/AppDrawer_widget.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeButton.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/AdaptativeTextField.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/cards/eletrodomesticosCard.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/GerenciarImageContainer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_comodos/comodo_bloc.dart';
import '../bloc_comodos/comodo_event.dart';
import '../bloc_gerenciarComodo/gerenciar_comodo_event.dart';
import 'cardComodo_Relay.dart';

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

class GerenciarComodosPage extends StatefulWidget {
  const GerenciarComodosPage(
      {super.key,
      required this.comodoImageUrl,
      required this.comodoNome,
      required this.comodoId});
  final String comodoImageUrl;
  final String comodoNome;
  final int comodoId;

  @override
  State<GerenciarComodosPage> createState() => _GerenciarComodosPageState();
}

class _GerenciarComodosPageState extends State<GerenciarComodosPage> {
  bool hasComodo = true; // bloc
  bool nomeUpdate = false; // bloc
  bool imageUpdate = false; // bloc
  ImagensComodos? selectedImage = ImagensComodos.plantaCasa;
  final titleController = TextEditingController();
  final imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _buildWhenComodo(
        GerenciarComodoState previusState, GerenciarComodoState currentState) {
      return currentState is GerenciarComodoInitialState ||
          currentState is GerenciarComodoShowImageState ||
          currentState is GerenciarComodoUpdatedState ||
          // currentState is GerenciarComodoEditingState ||
          currentState is GerenciarComodoLoadingState ||
          currentState is GerenciarComodoErrorState;
    }

    Widget _builderComodo(_, GerenciarComodoState state) {
      if (state is GerenciarComodoShowImageState) {
        return LayoutBuilder(builder: (context, constraints) {
          return Card(
              color: const Color.fromARGB(255, 235, 245, 235),
              elevation: 1,
              child: GerenciarImageContainer(
                constraints: constraints,
                imageUrl: imageUpdate ? selectedImage!.url : widget.comodoImageUrl,
              ));
        });
      }

      if (state is GerenciarComodoUpdatedState) {
        imageUpdate = true;
        return LayoutBuilder(builder: (context, constraints) {

          return SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // futura implementação: listar todos os eletrodomésticos em uma categoria
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  child: AdaptativeTextField(
                      keyboardType: TextInputType.text,
                      controller: titleController,
                      label: 'Nome: '),
                ),

                // implementar drop down com imagens fixas de eletrodomésticos
                SizedBox(height: constraints.maxHeight * 0.02),
                SizedBox(
                  width: constraints.maxWidth,
                  child: Row(
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DropdownMenu(
                              width: constraints.maxWidth * 0.6,
                              initialSelection: ImagensComodos.plantaCasa,
                              controller: imageUrlController,
                              requestFocusOnTap: true,
                              label: const Text('Cômodo'),
                              onSelected: (ImagensComodos? url) {
                                setState(() {
                                  selectedImage = url;
                                });
                              },
                              dropdownMenuEntries: ImagensComodos.values
                                  .map<DropdownMenuEntry<ImagensComodos>>(
                                      (ImagensComodos url) {
                                return DropdownMenuEntry<ImagensComodos>(
                                  value: url,
                                  label: url.label,
                                  enabled: url.label != 'Selecionar imagem',
                                );
                              }).toList()),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.05,
                      ),
                      Container(
                          height: constraints.maxHeight * 0.4,
                          width: constraints.maxWidth * 0.35,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: imageUrlController.text.isEmpty
                              ? const Text('Selecione uma imagem')
                              : FittedBox(
                                  child: Image.asset(
                                    selectedImage!.url.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/product_image_not_available.png",
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                )),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdaptativeButton(
                      label: 'Atualizar cômodo',
                      onPressed: () {
                        setState(() {
                          nomeUpdate = true;
                          context
                              .read<GerenciarComodoBloc>()
                              .add(AlterStateShowImage());
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      }
      if (state is GerenciarComodoLoadingState) {
        return const CircularProgressIndicator();
      }
      if (state is GerenciarComodoErrorState) {
        return const Text('Ainda não há comodos cadastrados');
      }
      return Container();
    }

    return LayoutBuilder(builder: (ctx, constraints) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: nomeUpdate
                ? Text("Gerenciando: ${titleController.text}")
                : Text("Gerenciando: ${widget.comodoNome}"),
          ),
          drawer: const AppDrawerWidget(),
          body: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              SizedBox(
                  height: constraints.maxHeight * 0.050,
                  child: RelayCardGerenciarComodos(
                    titleController: titleController.text,
                  )),

              SizedBox(
                height: constraints.maxHeight * 0.28,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                    top: 8,
                  ),
                  child: BlocBuilder<GerenciarComodoBloc, GerenciarComodoState>(
                    builder: _builderComodo,
                    buildWhen: _buildWhenComodo,
                  ),
                ),
              ),

              Card(
                  color: const Color.fromARGB(255, 235, 245, 235),
                  child: EletrodomesticosCard(constraints: constraints)),
              // Implementar drag and drop
              SizedBox(height: constraints.maxHeight * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Concluir',
                    onPressed: () async {
                      if (titleController.text.isNotEmpty) {
                        await ComodoBancodeDados.instance
                            .atualizarComodo(widget.comodoId,
                                titleController.text, selectedImage!.url)
                            .then(
                          (value) {
                            setState(() {
                              hasComodo = true;
                              nomeUpdate = true;
                              imageUpdate = true;
                            });
                          },
                        ).then((value) => Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainComodosPage(),
                                )));
                        context.read<ComodoBloc>().add(const GetComodos());
                      } else {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainComodosPage(),
                            ));
                      }
                    },
                  ),
                ],
              ),
            ],
          ));
    });
  }
}
