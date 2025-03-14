import 'package:equatable/equatable.dart';

// enum GerenciarComodoStatusS {
//   initial,
//   success,
//   error,
//   isUpdating,
//   loading,
//   updated,
//   created,
//   editing
// }

// extension GerenciarComodoStatusX on GerenciarComodoStatusS {
//   bool get isInitial => this == GerenciarComodoStatusS.initial;
//   bool get isSuccess => this == GerenciarComodoStatusS.success;
//   bool get isEditing => this == GerenciarComodoStatusS.editing;
//   bool get isError => this == GerenciarComodoStatusS.error;
//   bool get isUpdating => this == GerenciarComodoStatusS.isUpdating;
//   bool get isLoading => this == GerenciarComodoStatusS.loading;
//   bool get isUpdated => this == GerenciarComodoStatusS.updated;
//   bool get isCreated => this == GerenciarComodoStatusS.created;
// }

sealed class GerenciarComodoState extends Equatable {
  const GerenciarComodoState();
  @override
  List<Object> get props => [];
}

class GerenciarComodoInitialState extends GerenciarComodoState {
  const GerenciarComodoInitialState();
}
class GerenciarComodoShowImageState extends GerenciarComodoState {
  const GerenciarComodoShowImageState();
}

class GerenciarComodoLoadingState extends GerenciarComodoState {
  const GerenciarComodoLoadingState();
}

class GerenciarComodoSuccessState extends GerenciarComodoState {
  final Map atualizarComodos;
  GerenciarComodoSuccessState({Map? atualizarComodos})
      : atualizarComodos = atualizarComodos ?? {};

  @override
  List<Object> get props => [atualizarComodos];

  GerenciarComodoSuccessState copyWith({Map? atualizarComodos}) {
    return GerenciarComodoSuccessState(
      atualizarComodos: atualizarComodos ?? this.atualizarComodos,
    );
  }
}

class GerenciarComodoErrorState extends GerenciarComodoState {
  final String message;
  const GerenciarComodoErrorState({required this.message});
}

class GerenciarComodoUpdateComodoState extends GerenciarComodoState {
  final Map atualizarComodos;
  const GerenciarComodoUpdateComodoState({required this.atualizarComodos});
}

class GerenciarComodoEditingState extends GerenciarComodoState {
  const GerenciarComodoEditingState();
}

class GerenciarComodoUpdatedState extends GerenciarComodoState {
  const GerenciarComodoUpdatedState();
}

class GerenciarComodoEmptyMapState extends GerenciarComodoState {
  const GerenciarComodoEmptyMapState();
}
