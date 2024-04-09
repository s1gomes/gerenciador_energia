class Comodos {
  final String id;
  final String nome;
  final String urlImagem;
  List eletromesticos;
  
  Comodos ({
    required this.id,
    required this.nome,
    required this.urlImagem,
    this.eletromesticos = const [],
  });
}