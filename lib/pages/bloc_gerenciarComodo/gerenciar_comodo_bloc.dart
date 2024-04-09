import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_comodos/comodo_state.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_event.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';

class GerenciarComodoBloc extends Bloc<GerenciarComodoBlocEvents, GerenciarComodoBlocStates> {
  // @override
  // ComodoStates get initialState => InitialState();
  GerenciarComodoBloc( {
    required this.database
  }) : super(GerenciarComodoBlocStates()) {
    on<UpdateComodo>(_onUpdateComodo);
    // on<AlterState>(_alterState);
    on<AlterStateUpdated>(_alterStateUpdated);
    on<AlterStateInicial>(_alterStateisInicial);
    on<AlterStateEditing>(_alterStateisEditing);
  }

  final ComodoBancodeDados database;

  void _alterStateisInicial(AlterStateInicial event,  Emitter<GerenciarComodoBlocStates> emit) async { 
     emit(state.copyWith(statusGerenciarComodos: GerenciarComodoStatusS.initial));
  }

  void _alterStateisEditing(AlterStateEditing event,  Emitter<GerenciarComodoBlocStates> emit) async { 
     emit(state.copyWith(statusGerenciarComodos: GerenciarComodoStatusS.editing));
  }
  void _alterStateUpdated(AlterStateUpdated event,  Emitter<GerenciarComodoBlocStates> emit) async { 
    //  GerenciarComodoStatusS status;
     emit(state.copyWith(statusGerenciarComodos: GerenciarComodoStatusS.updated));
  }

  void _onUpdateComodo(UpdateComodo event, Emitter<GerenciarComodoBlocStates> emit) async {
    try {
      emit(state.copyWith(statusGerenciarComodos: GerenciarComodoStatusS.isUpdating));

      Map atualizarComodosMap = await database.atualizarComodo(event.idComodo, event.nomeComodo, event.urlImageComodo);

      emit(state.copyWith(
          statusGerenciarComodos: GerenciarComodoStatusS.updated, atualizarComodos: atualizarComodosMap));
    } catch (e) {
      print(e);
    }
  }
}
