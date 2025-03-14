import 'package:equatable/equatable.dart';

class GerenciarComodoBlocEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlterStateShowImage extends GerenciarComodoBlocEvents {
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
