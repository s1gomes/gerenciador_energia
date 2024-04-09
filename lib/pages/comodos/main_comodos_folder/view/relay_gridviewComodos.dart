import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/comodos/main_comodos_folder/view/gridview_todosComodos.dart';

class ComodosGridView extends StatelessWidget {
  const ComodosGridView({
    super.key,
    required this.constraints,
  });
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComodoBloc, ComodoStates>(
      builder: (context, state) {
        return state.statusComodos.isInitial
            ? const Text(
                "Cadastre um cômodo.",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )
            : state.statusComodos.isSuccess
                ? GridviewTodosComodos(
                    constraints: constraints,
                    dados: state.allComodos,
                  )
                : state.statusComodos.isLoading
                    ? const Center(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator()))
                    : state.statusComodos.isError
                        ? const Text('Ainda não há comodos cadastrados.')
                        : const SizedBox();
      },
    );
  }
}
