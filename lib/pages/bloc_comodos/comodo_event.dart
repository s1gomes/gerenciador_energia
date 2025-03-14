import 'package:equatable/equatable.dart';

sealed class ComodoEvents extends Equatable {
  const ComodoEvents();
  @override
  List<Object?> get props => [];
}

class GetComodos extends ComodoEvents {
  const GetComodos();
}
// receber url das imagens

class ImagemSelecionadaEvent extends ComodoEvents {
  const ImagemSelecionadaEvent();
}

class EditarImagemSelecionadaEvent extends ComodoEvents {
  const EditarImagemSelecionadaEvent();
}
