import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/AdaptativeTextField.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/CadastrarImagemCotainer.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/texrcardContainers/textCardContainer.dart';

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

class RelayCardGerenciarComodos extends StatefulWidget {
  const RelayCardGerenciarComodos({
    super.key,
    required this.titleController,
  });
  final String titleController;


  @override
  State<RelayCardGerenciarComodos> createState() =>
      _RelayCardGerenciarComodosState();
}

class _RelayCardGerenciarComodosState extends State<RelayCardGerenciarComodos> {
  ImagensComodos? selectedImage = ImagensComodos.plantaCasa;

  @override
  Widget build(BuildContext context) {
    bool _comodobuildWhen(
        GerenciarComodoState previusState, GerenciarComodoState currentState) {
      return 
          currentState is GerenciarComodoInitialState ||
          currentState is GerenciarComodoShowImageState ||
          currentState is GerenciarComodoErrorState ||
          currentState is GerenciarComodoUpdatedState ||
          currentState is GerenciarComodoLoadingState;
    }

    Widget _comodoBuilder(_, GerenciarComodoState state) {
      if (state is GerenciarComodoShowImageState) {
        return LayoutBuilder(builder: (context, constraints) {
          return TextCardContainer(
              constraints: constraints,
              titleController: "Cômodo ${widget.titleController}",
              functionOnpressed: () async {
                context.read<GerenciarComodoBloc>().add(AlterStateUpdated());
              },
              iconData: Icons.edit);
        });
      }
      // if (state is GerenciarComodoEditingState) {
      //   return LayoutBuilder(builder: (context, constraints) {
      //     return TextCardContainer(
      //         constraints: constraints,
      //         titleController: "Cômodo",
      //         functionOnpressed: () async {
      //           context.read<GerenciarComodoBloc>().add(AlterStateShowImage());
      //         },
      //         iconData: Icons.add);
      //   });
      // }
      if (state is GerenciarComodoUpdatedState) {
        return LayoutBuilder(builder: (context, constraints) {
          return TextCardContainer(
              constraints: constraints,
              titleController: "Cômodo ${widget.titleController}",
              functionOnpressed: () async {
                context.read<GerenciarComodoBloc>().add(AlterStateShowImage());
              },
              iconData: Icons.close);
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

    return LayoutBuilder(builder: (context, constraints) {
      return Card(
          color: const Color.fromARGB(255, 235, 245, 235),
          elevation: 2,
          child: BlocBuilder<GerenciarComodoBloc, GerenciarComodoState>(
            builder: _comodoBuilder,
            buildWhen: _comodobuildWhen,
          ));
    });
  }
}
