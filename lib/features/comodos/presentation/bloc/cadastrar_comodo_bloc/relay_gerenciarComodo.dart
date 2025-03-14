import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/AdaptativeTextField.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/CadastrarImagemCotainer.dart';

import '../bloc_gerenciarComodo/gerenciar_comodo_state.dart';

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

class RelayGerenciarComodos extends StatefulWidget {
  const RelayGerenciarComodos({
    super.key,
    // required this.constraints,
    required this.selectedImageUrl,
    required this.nomeComodo,
    required this.imageComodo,
  });
  // final BoxConstraints constraints;
  final String selectedImageUrl;
  final TextEditingController nomeComodo;
  final TextEditingController imageComodo;

  @override
  State<RelayGerenciarComodos> createState() => _RelayGerenciarComodosState();
}

class _RelayGerenciarComodosState extends State<RelayGerenciarComodos> {
  ImagensComodos? selectedImage = ImagensComodos.plantaCasa;
  @override
  Widget build(BuildContext context) {
    bool _buildWhenComodo(
        GerenciarComodoState previusState, GerenciarComodoState currentState) {
      return currentState is GerenciarComodoInitialState ||
          currentState is GerenciarComodoUpdatedState ||
          currentState is GerenciarComodoErrorState ||
          currentState is GerenciarComodoLoadingState;
    }

    Widget _builderComodo(_, GerenciarComodoState state) {
      if (state is GerenciarComodoInitialState) {
        return Card(
            color: const Color.fromARGB(255, 235, 245, 235),
            elevation: 2,
            child: CadastrarImageContainer(
              // constraints: constraints,
              imageController: widget.selectedImageUrl,
            ));
      }
      if (state is GerenciarComodoUpdatedState) {
        return LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // futura implementação: listar todos os eletrodomésticos em uma categoria
              AdaptativeTextField(
                  keyboardType: TextInputType.text,
                  controller: widget.nomeComodo,
                  label: 'Nome: '),

              // implementar drop down com imagens fixas de eletrodomésticos
              SizedBox(height: constraints.maxHeight * 0.02),
              Row(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.2,
                    width: constraints.maxWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: DropdownMenu(
                          width: constraints.maxWidth * 0.6,
                          initialSelection: ImagensComodos.plantaCasa,
                          controller: widget.imageComodo,
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
                  Container(
                      height: constraints.maxHeight * 0.2,
                      width: constraints.maxWidth * 0.02,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: widget.imageComodo.text.isEmpty
                          ? const Text('Informe a Url')
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
                            ))
                ],
              ),
            ],
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

    return LayoutBuilder(
        // "subir" esse widget para que o botão de concluir consiga pegar a informação correta
        // na forma atual, o title controller vai vazio levando o imagewidget a cair no 'onError' e mostrar a imagem planta casa
        builder: (context, constraints) {
      return BlocBuilder<GerenciarComodoBloc, GerenciarComodoState>(
        builder: _builderComodo,
        buildWhen: _buildWhenComodo,
      );
    });
  }
}
