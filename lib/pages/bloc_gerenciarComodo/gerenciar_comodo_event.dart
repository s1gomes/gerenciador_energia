import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_energia_bloc/pages/bloc_gerenciarComodo/gerenciar_comodo_state.dart';
import 'package:gerenciamento_energia_bloc/shared/widgets/compartmentalization/containers/imageContainers/GerenciarImageContainer.dart';

class GerenciarComodoBlocEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlterStateInicial extends GerenciarComodoBlocEvents {
  @override
  List<Object?> get props => [];
}

class AlterStateUpdated extends GerenciarComodoBlocEvents {
  @override
  List<Object?> get props => [];
}
class AlterStateEditing extends GerenciarComodoBlocEvents {
  @override
  List<Object?> get props => [];
}

class UpdateComodo extends GerenciarComodoBlocEvents {
  UpdateComodo({
    required this.idComodo,
    required this.nomeComodo,
    required this.urlImageComodo,
  });

  final String nomeComodo;
  final int idComodo;
  final String urlImageComodo;

  @override
  List<Object?> get props => [nomeComodo, idComodo, urlImageComodo];
}
// receber url das imagens


// class ImagemSelecionadaEvent extends ComodoEvents {
//   @override
//   List<Object?> get props => [];
// }

// class EditarImagemSelecionadaEvent extends ComodoEvents {
//   @override
//   List<Object?> get props => [];
// }
