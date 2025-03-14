import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_state.dart';

class ComodoBloc extends Bloc<ComodoEvents, ComodosStates> {
  // @override
  // ComodosStates get initialState => InitialState();
  final ComodoBancodeDados comodoBancodeDados;
  ComodoBloc({required this.comodoBancodeDados})
      : super(ComodosInitialState()) {
    on<GetComodos>(_onGetComodos);
  }

  void _onGetComodos(GetComodos event, Emitter<ComodosStates> emit) async {
    try {
      emit(const ComodosLoadingState());

      List allComodos = await comodoBancodeDados.recuperarTodos();
      if (allComodos.isEmpty) {
        emit(const ComodosInitialState());
        allComodos.clear();
      }
      // emit(state.copyWith(statusComodos: ComodosStatusS.created));
      // print("state comodobloc $state");
      // print(" all comodos $allComodos");

      emit(ComodoSuccessState(allComodos: allComodos));
    } catch (exception) {
      emit(ComodoErrorState(message: "$exception"));
    }
  }
}
