import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciamento_energia_bloc/data/db/db.dart';
import 'package:gerenciamento_energia_bloc/features/comodos/presentation/bloc/bloc_gerenciarComodo/gerenciar_comodo_state.dart';

import 'gerenciar_comodo_event.dart';

class GerenciarComodoBloc extends Bloc<GerenciarComodoBlocEvents, GerenciarComodoState> {
  // @override
  // ComodoStates get initialState => InitialState();
  GerenciarComodoBloc( {
    required this.database
  }) : super(const GerenciarComodoInitialState()) {
    on<UpdateComodo>(_onUpdateComodo);
    // on<AlterState>(_alterState);
    on<AlterStateUpdated>(_alterStateUpdated);
    on<AlterStateShowImage>(_alterStateisShowImage);
    on<AlterStateEditing>(_alterStateisEditing);
  }

  final ComodoBancodeDados database;

  void _alterStateisShowImage(AlterStateShowImage event,  Emitter<GerenciarComodoState> emit) async { 
     emit(const GerenciarComodoShowImageState());
  }

  void _alterStateisEditing(AlterStateEditing event,  Emitter<GerenciarComodoState> emit) async { 
    emit(const GerenciarComodoEditingState());
  }
  void _alterStateUpdated(AlterStateUpdated event,  Emitter<GerenciarComodoState> emit) async { 
    //  GerenciarComodoStatusS status;
    emit(const GerenciarComodoUpdatedState());
  }

  void _onUpdateComodo(UpdateComodo event, Emitter<GerenciarComodoState> emit) async {
    try {
      emit(const GerenciarComodoLoadingState());
      

      Map atualizarComodosMap = await database.atualizarComodo(event.idComodo, event.nomeComodo, event.urlImageComodo);
emit(GerenciarComodoUpdateComodoState(atualizarComodos: atualizarComodosMap));
    
    } catch (exception) {
      emit(GerenciarComodoErrorState(message: exception.toString()));
    }
  }
}
