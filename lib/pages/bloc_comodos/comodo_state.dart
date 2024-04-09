import 'package:equatable/equatable.dart';

enum ComodosStatusS {
  initial,
  success,
  error,
  loading,
  updated,
  created
}

extension ComodosStatusX on ComodosStatusS {
  bool get isInitial => this == ComodosStatusS.initial;
  bool get isSuccess => this == ComodosStatusS.success;
  bool get isError => this == ComodosStatusS.error;
  bool get isLoading => this == ComodosStatusS.loading;
  bool get isUpdated => this == ComodosStatusS.updated;
  bool get isCreated => this == ComodosStatusS.created;
}

class ComodoStates extends Equatable {
   ComodoStates(
      {this.statusComodos = ComodosStatusS.initial, List? allComodos})
      : allComodos = allComodos ?? [];

  final ComodosStatusS statusComodos;
  final List allComodos;

  @override
  List<Object?> get props => [statusComodos, allComodos];

  ComodoStates copyWith({ComodosStatusS? statusComodos, List? allComodos}) {
    return ComodoStates(
      statusComodos: statusComodos ?? this.statusComodos,
      allComodos: allComodos ?? this.allComodos,

    );
  }
}
