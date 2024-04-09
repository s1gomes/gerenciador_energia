import 'package:flutter/material.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/components/bloc/cardComodo_Relay.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/main_comodos.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/AppDrawer_widget.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeButton.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeTextField.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/cards/eletrodomesticosCard.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/GerenciarImageContainer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              // Card(
              //   elevation: 3,
              //   child: Row(
              //     mainAxisAlignrment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       SizedBox(
              //         width: constraints.maxWidth * 0.03,
              //       ),
              //       Container(
              //           height: constraints.maxHeight * 0.060,
              //           width: constraints.maxWidth * 0.75,
              //           child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text(
              //                 nomeUpdate
              //                     ? "Editar cômodo ${titleController.text}"
              //                     : "Editar cômodo ${widget.comodoNome}",
              //                 style: const TextStyle(
              //                   fontSize: 17,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ))),
              //       IconButton(
              //         onPressed: () {
              //           setState(() {
              //             hasComodo = false;
              //           });
              //         },
              //         icon: const Icon(Icons.edit),
              //       )
              //     ],
              //   ),
              // ),
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
                              elevation: 1,
                              child: GerenciarImageContainer(
                                constraints: constraints,
                                imageUrl: widget.comodoImageUrl,
                              ))
                          : state.statusGerenciarComodos.isUpdated
                              ? Card(
                                  color:
                                      const Color.fromARGB(255, 235, 245, 235),
                                  elevation: 1,
                                  child: GerenciarImageContainer(
                                    constraints: constraints,
                                    imageUrl: selectedImage!.url,
                                  ))
                              : state.statusGerenciarComodos.isEditing
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
                                            height:
                                                constraints.maxHeight * 0.02),
                                        Row(
                                          children: [
                                            Container(
                                              height:
                                                  constraints.maxHeight * 0.10,
                                              width:
                                                  constraints.maxWidth * 0.65,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: DropdownMenu(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.6,
                                                    initialSelection:
                                                        ImagensComodos
                                                            .plantaCasa,
                                                    controller:
                                                        imageUrlController,
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
                                                            (ImagensComodos
                                                                url) {
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
                                                height: constraints.maxHeight *
                                                    0.10,
                                                width:
                                                    constraints.maxWidth * 0.24,
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                ),
                                                alignment: Alignment.center,
                                                child: imageUrlController
                                                        .text.isEmpty
                                                    ? const Text(
                                                        'Selecione uma imagem')
                                                    : FittedBox(
                                                        child: Image.asset(
                                                          selectedImage!.url
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                              "assets/images/product_image_not_available.png",
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                        ),
                                                      )),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            AdaptativeButton(
                                              label: 'Atualizar cômodo',
                                              onPressed: () {
                                                setState(() {
                                                  nomeUpdate = true;
                                                  context
                                                      .read<
                                                          GerenciarComodoBloc>()
                                                      .add(AlterStateUpdated());
                                                });
                                              },
                                            ),
                                          ],
                                        ),
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
                      context.read<ComodoBloc>().add(GetComodos());
                      // context
                      //     .read<GerenciarComodoBloc>()
                      //     .add(AlterStateInicial());
                    },
                    // onPressed: () {

                    // },
                  ),
                ],
              ),
            ],
          ));
    });
  }
}


/*


AdaptativeButton(
                                    label: 'Atualizar',
                                    onPressed: () {
                                      if (titleController.text.isNotEmpty ||
                                          !hasBeenSaved) {
                                        // LoginBancodeDados.instance
                                        //     .recuperarTodos()
                                        //     .then((value) async {
                                        //   ELoginRepository.fazendoLogin(
                                        //           usuarioController.text.toUpperCase(),
                                        //           senha,
                                        //           empresaSelecionada!.idEmpresa)
                                        //       .then((usuario) async {
                                        //     if (ELoginRepository.statusCode) {
                                        //       setState(() {
                                        //         errorText =
                                        //             'Usuário ou Senha incorretos!';
                                        //         loading = false;
                                        //       });
                                        //     }

                                        // receber id do comodo
                                        // ComodoBancodeDados.instance
                                        //     .recuperarTodos()
                                        //     .then((all) {
                                        //       int comodoId = all.where((e) => e['idComodo']);

                                          ComodoBancodeDados.instance
                                              .atualizarComodo(
                                                  comodoId,
                                                  titleController.text,
                                                  selectedImage!.url)
                                              .then(
                                            (value) {
                                              setState(() {
                                                context
                                                    .read<ComodoBloc>()
                                                    .add(GetComodos());

                                                titleController.clear();
                                                hasComodo = true;
                                                hasBeenSaved = true;
                                              });
                                            },
                                          );
                                          Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainComodosPage(),
                                              ));
                                        // });
                                      }
                                    },
                                  )
*/

