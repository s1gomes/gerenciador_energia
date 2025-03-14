import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_comodos/comodo_bloc.dart';
import '../bloc/bloc_comodos/comodo_state.dart';
import 'gridview_todosComodos.dart';

class ComodosGridView extends StatelessWidget {
  const ComodosGridView({
    super.key,
    required this.constraints,
  });
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    bool _buildWhenComodo(
        ComodosStates previusState, ComodosStates currentState) {
      return currentState is ComodosInitialState ||
          currentState is ComodosInitialState ||
          currentState is ComodosLoadingState ||
          currentState is ComodoSuccessState ||
          currentState is ComodoErrorState ||
          currentState is ComodoEmptyListState;
    }

    Widget _builderComodo(_, ComodosStates state) {
      if (state is ComodosInitialState) {
        return const Text(
          "Cadastre um cômodo.",
          style: TextStyle(color: Colors.black, fontSize: 18),
        );
      }
      if (state is ComodoSuccessState) {
        return GridviewTodosComodos(
          constraints: constraints,
          dados: state.allComodos,
        );
      }
      if (state is ComodosLoadingState) {
        return const Center(
            child: SizedBox(
                height: 100, width: 100, child: CircularProgressIndicator()));
      }
      if (state is ComodoErrorState) {
        return const Text('Ainda não há comodos cadastrados.');
      }
      return const SizedBox();
    }

    return BlocBuilder<ComodoBloc, ComodosStates>(
        builder: _builderComodo, buildWhen: _buildWhenComodo);
  }
}
