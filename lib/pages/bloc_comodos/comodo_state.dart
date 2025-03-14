import 'package:equatable/equatable.dart';

// enum ComodosStatusS {
//   initial,
//   success,
//   error,
//   loading,
//   updated,
//   created
// }

// extension ComodosStatusX on ComodosStatusS {
//   bool get isInitial => this == ComodosStatusS.initial;
//   bool get isSuccess => this == ComodosStatusS.success;
//   bool get isError => this == ComodosStatusS.error;
//   bool get isLoading => this == ComodosStatusS.loading;
//   bool get isUpdated => this == ComodosStatusS.updated;
//   bool get isCreated => this == ComodosStatusS.created;
// }
sealed class ComodosStates extends Equatable {
  const ComodosStates();
  @override
  List<Object> get props => [];
}

class ComodosInitialState extends ComodosStates {
  const ComodosInitialState();
}

class ComodosLoadingState extends ComodosStates {
  const ComodosLoadingState();
}

class ComodoSuccessState extends ComodosStates {
  // final ComodosStatusS statusComodos;
  final List allComodos;
  const ComodoSuccessState({required this.allComodos});

  @override
  List<Object> get props => [allComodos];

  ComodoSuccessState copyWith({List? allComodos}) {
    return ComodoSuccessState(
      allComodos: allComodos ?? this.allComodos,
    );
  }
}

class ComodoErrorState extends ComodosStates {
  final String message;
  const ComodoErrorState({required this.message});
}

class ComodoEmptyListState extends ComodosStates {
  const ComodoEmptyListState();
}
