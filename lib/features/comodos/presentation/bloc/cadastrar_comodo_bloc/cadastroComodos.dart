import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/pages/home/main_comodos.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/AppDrawer_widget.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeButton.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/AdaptativeTextField.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/cards/eletrodomesticosCard.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/CadastrarImagemCotainer.dart';

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

class CadastroComodosPage extends StatefulWidget {
  const CadastroComodosPage({super.key});

  @override
  State<CadastroComodosPage> createState() => _CadastroComodosPageState();
}

class _CadastroComodosPageState extends State<CadastroComodosPage> {
  ImagensComodos? selectedImage = ImagensComodos.plantaCasa;
  // final _imageURLFocus = FocusNode();
  final titleController = TextEditingController();
  final imageController = TextEditingController();

  bool hasComodo = false; //bloc

  bool hasBeenSaved = false;

  @override
  Widget build(BuildContext context) {
    bool _buildWhenComodo(
        GerenciarComodoState previusState, GerenciarComodoState currentState) {
      return currentState is GerenciarComodoInitialState ||
          currentState is GerenciarComodoUpdatedState ||
          currentState is GerenciarComodoShowImageState ||
          currentState is GerenciarComodoLoadingState ||
          currentState is GerenciarComodoErrorState;
    }

    Widget _builderComodo(_, GerenciarComodoState state) {
      if (state is GerenciarComodoShowImageState) {
        return Card(
            color: const Color.fromARGB(255, 235, 245, 235),
            elevation: 2,
            child: CadastrarImageContainer(
              // constraints: constraints,
              imageController: selectedImage!.url.toString(),
            ));
      }
      if (state is GerenciarComodoUpdatedState) {
        return LayoutBuilder(builder: (context, constraints) {
          return Container(
            // height: constraints.maxHeight * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // futura implementação: listar todos os eletrodomésticos em uma categoria
                Container(
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
                        // width: constraints.maxWidth * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DropdownMenu(
                              width: constraints.maxWidth * 0.6,
                              initialSelection: ImagensComodos.plantaCasa,
                              controller: imageController,
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
                          // margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: imageController.text.isEmpty
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
                AdaptativeButton(
                  label: 'Cadastrar cômodo',
                  onPressed: () {
                    setState(() {
                      context
                          .read<GerenciarComodoBloc>()
                          .add(AlterStateShowImage());

                      hasComodo = true;
                      hasBeenSaved = true;
                    });
                  },
                )
              ],
            ),
          );
        });
      }
      if (state is GerenciarComodoLoadingState) {
        return const Text("Atualizando");
      }
      if (state is GerenciarComodoErrorState) {
        return const Text('Ainda não há comodos cadastrados');
      }

      return Container();
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('Cadastrando ${titleController.text}'),
          ),
          resizeToAvoidBottomInset: false,
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
                height: constraints.maxHeight * 0.3,
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
              SizedBox(
                height: constraints.maxHeight * 0.050,
                child: Card(
                    color: const Color.fromARGB(255, 235, 245, 235),
                    child: EletrodomesticosCard(constraints: constraints)),
              ),
              SizedBox(height: constraints.maxHeight * 0.1),
              SizedBox(
                height: constraints.maxHeight * 0.050,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdaptativeButton(
                      label: 'Concluir',
                      onPressed: () {
                        if (titleController.text.isNotEmpty || !hasBeenSaved) {
                          ComodoBancodeDados.instance
                              .salvarComodos(
                                  titleController.text, selectedImage!.url)
                              .then(
                            (value) {
                              // print(
                              //     " selected image cadastro comodos ${selectedImage!.url}");
                              setState(() {
                                context
                                    .read<ComodoBloc>()
                                    .add(const GetComodos());

                                titleController.clear();
                                hasComodo = true;
                                hasBeenSaved = true;
                              });
                            },
                          );
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainComodosPage(),
                              ));
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
