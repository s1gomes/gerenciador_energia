import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/cadastrar_comodo_bloc/cadastroComodos.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/texrcardContainers/textCardContainer.dart';

import '../bloc_gerenciarComodo/gerenciar_comodo_event.dart';

class ComodosCardMP extends StatelessWidget {
  const ComodosCardMP({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GerenciarComodoBloc, GerenciarComodoState>(
        builder: (context, state) {
      return Container(
        width: constraints.maxWidth * 0.98,
        height: constraints.maxHeight * 0.07,
        child: Card(
            elevation: 3,
            child: TextCardContainer(
              titleController: "Cômodo",
              constraints: constraints,
              functionOnpressed: () {
                context.read<GerenciarComodoBloc>().add(AlterStateUpdated());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CadastroComodosPage()),
                );
              },
              iconData: Icons.add,
            )),
      );
    });
  }
}
