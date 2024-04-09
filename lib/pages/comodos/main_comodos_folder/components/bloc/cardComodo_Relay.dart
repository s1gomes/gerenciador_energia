import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeTextField.dart';
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
    // // required this.constraints,
    // required this.selectedImageUrl,
    // required this.nomeComodo,
    // required this.imageComodo,
  });
  // final BoxConstraints constraints;
  final String titleController;
  // final TextEditingController nomeComodo;
  // final TextEditingController imageComodo;

  @override
  State<RelayCardGerenciarComodos> createState() =>
      _RelayCardGerenciarComodosState();
}

class _RelayCardGerenciarComodosState extends State<RelayCardGerenciarComodos> {
  Widget textCard(constraints) {
    return BlocBuilder<GerenciarComodoBloc, GerenciarComodoBlocStates>(
      builder: (context, state) {
        return state.statusGerenciarComodos.isEditing
            ? TextCardContainer(
                constraints: constraints,
                titleController: "Cômodo",
                functionOnpressed: () async {
                  context.read<GerenciarComodoBloc>().add(AlterStateInicial());
                },
                iconData: Icons.add)
            : state.statusGerenciarComodos.isUpdated
                ? TextCardContainer(
                    constraints: constraints,
                    titleController: "Cômodo ${widget.titleController}",
                    functionOnpressed: () async {
                      context
                          .read<GerenciarComodoBloc>()
                          .add(AlterStateEditing());
                    },
                    iconData: Icons.edit)
                : state.statusGerenciarComodos.isInitial
                    ? TextCardContainer(
                        constraints: constraints,
                        titleController: "Cômodo ${widget.titleController}",
                        functionOnpressed: () async {
                          context
                              .read<GerenciarComodoBloc>()
                              .add(AlterStateEditing());
                        },
                        iconData: Icons.edit)
                    : state.statusGerenciarComodos.isUpdating
                        ? const CircularProgressIndicator()
                        : state.statusGerenciarComodos.isError
                            ? const Text('Ainda não há comodos cadastrados')
                            : const SizedBox();
      },
    );
  }

  // final Enum ImagensComodos;
  ImagensComodos? selectedImage = ImagensComodos.plantaCasa;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
          color: const Color.fromARGB(255, 235, 245, 235),
          elevation: 2,
          child: textCard(constraints));
    });
  }
}
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
// import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_event.dart';
// import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
// import 'package:gerenciamento_energia_bloc/shared/widgets/adaptatives/adaptativeTextField.dart';
// import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/CadastrarImagemCotainer.dart';
// import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/texrcardContainers/textCardContainer.dart';

// enum ImagensComodos {
//   cozinha("Cozinha", "assets/images/cozinha.jpg"),
//   mesaCadeiraPreta("Sala de jantar", "assets/images/mesa_cadeira_preta.jpg"),
//   mesaJanela("Varanda", "assets/images/mesa_com_janela.jpg"),
//   plantaCasa("Planta da Casa", "assets/images/planta.jpeg"),
//   sala("Sala", "assets/images/sala.jpg");

//   const ImagensComodos(this.label, this.url);
//   final String label;
//   final String url;
// }

// class RelayCardGerenciarComodos extends StatefulWidget {
//   const RelayCardGerenciarComodos({
//     super.key,
//     required this.titleController,
//     // // required this.constraints,
//     // required this.selectedImageUrl,
//     // required this.nomeComodo,
//     // required this.imageComodo,
//   });
//   // final BoxConstraints constraints;
//   final String titleController;
//   // final TextEditingController nomeComodo;
//   // final TextEditingController imageComodo;

//   @override
//   State<RelayCardGerenciarComodos> createState() =>
//       _RelayCardGerenciarComodosState();
// }

// class _RelayCardGerenciarComodosState extends State<RelayCardGerenciarComodos> {
//   // final Enum ImagensComodos;
//   ImagensComodos? selectedImage = ImagensComodos.plantaCasa;
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return BlocBuilder<GerenciarComodoBloc, GerenciarComodoBlocStates>(
//         builder: (context, state) {
//           return state.statusGerenciarComodos.isEditing
//               ? Card(
//                   color: const Color.fromARGB(255, 235, 245, 235),
//                   elevation: 2,
//                   child: TextCardContainer(
//                       constraints: constraints,
//                       titleController: "Cômodo",
//                       functionOnpressed: () async {
//                         context
//                             .read<GerenciarComodoBloc>()
//                             .add(AlterStateInicial());
//                       },
//                       iconData: Icons.add))
//               : state.statusGerenciarComodos.isInitial
//                   ? Card(
//                       color: const Color.fromARGB(255, 235, 245, 235),
//                       child: TextCardContainer(
//                           constraints: constraints,
//                           titleController: "Cômodo " + widget.titleController,
//                           functionOnpressed: () async {
//                             context
//                                 .read<GerenciarComodoBloc>()
//                                 .add(AlterStateEditing());
//                           },
//                           iconData: Icons.edit),
//                     )
//                   : state.statusGerenciarComodos.isUpdating
//                       ? Text("Atualizando")
//                       : state.statusGerenciarComodos.isError
//                           ? const Text('Ainda não há comodos cadastrados')
//                           : const SizedBox();
//         },
//       );
//     });
//   }
// }
