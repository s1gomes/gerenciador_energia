class EletrodomesticoModel {
  final int id;
  final String name;
  final String voltagem;
  final String wattshora;
  final String consumoDeclarado;
  final String consumoEstimado;

  const EletrodomesticoModel({
    required this.id,
    required this.name,
    required this.voltagem,
    required this.wattshora,
    required this.consumoDeclarado,
    required this.consumoEstimado
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'voltagem': voltagem,
      'wattshora' : wattshora,
      'consumoDeclarado' : consumoDeclarado,
      'consumoEstimado' : consumoEstimado
    };
  }

  @override
  String toString() {
    return 'EletrodomesticoModel(id: $id, name: $name, voltagem: $voltagem, wattshora: $wattshora, consumoDeclarado: $consumoDeclarado, consumoEstimado: $consumoEstimado)';
  }
}