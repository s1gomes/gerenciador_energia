import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_bloc.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';

class ComodoBloc extends Bloc<ComodoEvents, ComodoStates> {
  // @override
  // ComodoStates get initialState => InitialState();
  ComodoBloc({required this.database}) : super(ComodoStates()) {
    on<GetComodos>(_onGetComodos);
  }

  final ComodoBancodeDados database;

  void _onGetComodos(GetComodos event, Emitter<ComodoStates> emit) async {
    try {
      emit(state.copyWith(statusComodos: ComodosStatusS.loading));

      List allComodos = await ComodoBancodeDados.instance.recuperarTodos();
      if (allComodos.isEmpty) {
        emit(state.copyWith(statusComodos: ComodosStatusS.initial));
        allComodos.clear();
      }
      // emit(state.copyWith(statusComodos: ComodosStatusS.created));
      print("state comodobloc $state");
      print(" all comodos $allComodos");

      emit(state.copyWith(
          statusComodos: ComodosStatusS.success, allComodos: allComodos));
    } catch (e) {
      print(e);
    }
  }
}
