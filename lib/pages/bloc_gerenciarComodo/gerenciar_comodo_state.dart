import 'package:equatable/equatable.dart';

enum GerenciarComodoStatusS {
  initial,
  success,
  error,
  isUpdating,
  loading,
  updated,
  created,
  editing
}

extension GerenciarComodoStatusX on GerenciarComodoStatusS {
  bool get isInitial => this == GerenciarComodoStatusS.initial;
  bool get isSuccess => this == GerenciarComodoStatusS.success;
  bool get isEditing => this == GerenciarComodoStatusS.editing;
  bool get isError => this == GerenciarComodoStatusS.error;
  bool get isUpdating => this == GerenciarComodoStatusS.isUpdating;
  bool get isLoading => this == GerenciarComodoStatusS.loading;
  bool get isUpdated => this == GerenciarComodoStatusS.updated;
  bool get isCreated => this == GerenciarComodoStatusS.created;
}

class GerenciarComodoBlocStates extends Equatable {
   GerenciarComodoBlocStates(
      {this.statusGerenciarComodos = GerenciarComodoStatusS.initial, Map? atualizarComodos})
      : atualizarComodos = atualizarComodos ?? {};

  final GerenciarComodoStatusS statusGerenciarComodos;
  final Map atualizarComodos;

  @override
  List<Object?> get props => [statusGerenciarComodos, atualizarComodos];

  GerenciarComodoBlocStates copyWith({GerenciarComodoStatusS? statusGerenciarComodos, Map? atualizarComodos}) {
    return GerenciarComodoBlocStates(
      statusGerenciarComodos: statusGerenciarComodos ?? this.statusGerenciarComodos,
      atualizarComodos: atualizarComodos ?? this.atualizarComodos,
    );
  }
}
