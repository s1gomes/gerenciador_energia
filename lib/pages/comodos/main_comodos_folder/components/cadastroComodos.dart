import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/components/bloc/cardComodo_Relay.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/components/bloc/relay_gerenciarComodo.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/main_comodos.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/AppDrawer_widget.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeButton.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeTextField.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/cards/eletrodomesticosCard.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/CadastrarImagemCotainer.dart';

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
  final _imageURLFocus = FocusNode();
  final titleController = TextEditingController();
  final imageController = TextEditingController();

  bool hasComodo = false; //bloc

  bool hasBeenSaved = false;

  @override
  Widget build(BuildContext context) {
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
                height: constraints.maxHeight * 0.28,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                    top: 8,
                  ),
                  child: BlocBuilder<GerenciarComodoBloc,
                      GerenciarComodoBlocStates>(
                    builder: (context, state) {
                      return state.statusGerenciarComodos.isInitial
                          ? Card(
                              color: const Color.fromARGB(255, 235, 245, 235),
                              elevation: 2,
                              child: CadastrarImageContainer(
                                // constraints: constraints,
                                imageController: selectedImage!.url.toString(),
                              ))
                          : state.statusGerenciarComodos.isUpdated
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // futura implementação: listar todos os eletrodomésticos em uma categoria
                                    adaptativeTextField(
                                        keyboardType: TextInputType.text,
                                        controller: titleController,
                                        label: 'Nome: '),

                                    // implementar drop down com imagens fixas de eletrodomésticos
                                    SizedBox(
                                        height: constraints.maxHeight * 0.02),
                                    Row(
                                      children: [
                                        Container(
                                          height: constraints.maxHeight * 0.10,
                                          width: constraints.maxWidth * 0.65,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: DropdownMenu(
                                                width:
                                                    constraints.maxWidth * 0.6,
                                                initialSelection:
                                                    ImagensComodos.plantaCasa,
                                                controller: imageController,
                                                requestFocusOnTap: true,
                                                label: const Text('Cômodo'),
                                                onSelected:
                                                    (ImagensComodos? url) {
                                                  setState(() {
                                                    selectedImage = url;
                                                  });
                                                },
                                                dropdownMenuEntries:
                                                    ImagensComodos.values.map<
                                                            DropdownMenuEntry<
                                                                ImagensComodos>>(
                                                        (ImagensComodos url) {
                                                  return DropdownMenuEntry<
                                                      ImagensComodos>(
                                                    value: url,
                                                    label: url.label,
                                                    enabled: url.label !=
                                                        'Selecionar imagem',
                                                  );
                                                }).toList()),
                                          ),
                                        ),
                                        Container(
                                            height:
                                                constraints.maxHeight * 0.10,
                                            width: constraints.maxWidth * 0.24,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            alignment: Alignment.center,
                                            child: imageController.text.isEmpty
                                                ? const Text(
                                                    'Selecione uma imagem')
                                                : FittedBox(
                                                    child: Image.asset(
                                                      selectedImage!.url
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Image.asset(
                                                          "assets/images/product_image_not_available.png",
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  )),
                                      ],
                                    ),
                                    AdaptativeButton(
                                      label: 'Cadastrar cômodo',
                                      onPressed: () {
                                        setState(() {
                                          // context.read<ComodoBloc>().add(GetComodos());

                                          //  emit(state.copyWith(statusGerenciarComodos: GerenciarComodoStatusS.created));
                                          context
                                              .read<GerenciarComodoBloc>()
                                              .add(AlterStateInicial());
                                          print(
                                              "state cadastro comodos $state");
                                          // titleController.clear();
                                          hasComodo = true;
                                          hasBeenSaved = true;
                                        });
                                        // if (titleController.text.isNotEmpty ||
                                        //     !hasBeenSaved) {
                                        //   ComodoBancodeDados.instance
                                        //       .salvarComodos(
                                        //           titleController.text,
                                        //           selectedImage!.url)
                                        //       .then(
                                        //     (value) {
                                        //       print(
                                        //           " selected image cadastro comodos ${selectedImage!.url}");

                                        //     },
                                        //   );
                                        //   // Navigator.pop(
                                        //   //     context,
                                        //   //     MaterialPageRoute(
                                        //   //       builder: (context) => const MainComodosPage(),
                                        //   //     ));
                                        // }
                                      },
                                    )
                                  ],
                                )
                              : state.statusGerenciarComodos.isUpdating
                                  ? Text("Atualizando")
                                  : state.statusGerenciarComodos.isError
                                      ? const Text(
                                          'Ainda não há comodos cadastrados')
                                      : const SizedBox();
                    },
                  ),
                  // child: RelayGerenciarComodos(
                  //   imageComodo: imageController,
                  //   nomeComodo: titleController,
                  //   selectedImageUrl: imageController.text,
                  // )
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
                              print(
                                  " selected image cadastro comodos ${selectedImage!.url}");
                              setState(() {
                                context.read<ComodoBloc>().add(GetComodos());

                                //  emit(state.copyWith(statusGerenciarComodos: GerenciarComodoStatusS.created));
                                // context.read<GerenciarComodoBloc>().add(UpdateComodo(

                                // ));

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
