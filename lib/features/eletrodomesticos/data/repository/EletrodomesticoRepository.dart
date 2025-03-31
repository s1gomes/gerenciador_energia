


import 'package:gerenciamento_energia_bloc/features/eletrodomesticos/data/data_sources/remote/EletrodomesticoDatabaseHelper.dart';

import '../models/EletrodomesticoModel.dart';

class  EletrodomesticoRepository {

  final EletroDatabaseHelper eletroDatabaseHelper = EletroDatabaseHelper();

  Future<List<Map<String, dynamic>>> getAllEletrodomesticos(
      int id
      ) async {
    var eletrodomesticos;
    print("eletrodomesticos $eletrodomesticos");
    try {
      eletrodomesticos = eletroDatabaseHelper.getAllEletrodomesticos(id);
      print("all eletrodomesticos $eletrodomesticos");
    } catch ( exception ){
      print(exception.toString());
    }
    return eletrodomesticos;
  }

  Future<int> insertEletro(
      EletrodomesticoModel eletro
      ) async {
    var eletrodomesticos;
    print("eletrodomesticos $eletrodomesticos");
    try {
      eletrodomesticos = eletroDatabaseHelper.insertEletro(eletro);
      print("inserted eletrodomesticos $eletrodomesticos");
    } catch ( exception ){
      print(exception.toString());
    }
    return eletrodomesticos;
  }

  Future<int> updateEletro(
      EletrodomesticoModel eletro
      ) async {
    var eletrodomesticos;
    print("eletrodomesticos $eletrodomesticos");
    try {
      eletrodomesticos = eletroDatabaseHelper.updateEletro(eletro);
      print("updated eletrodomesticos $eletrodomesticos");
    } catch ( exception ){
      print(exception.toString());
    }
    return eletrodomesticos;
  }

  Future<int> deleteEletro(
      int id
      ) async {
    var eletrodomesticos;
    print("eletrodomesticos $eletrodomesticos");
    try {
      eletrodomesticos = eletroDatabaseHelper.deleteEletro(id);
      print("deleted eletrodomesticos $eletrodomesticos");
    } catch ( exception ){
      print(exception.toString());
    }
    return eletrodomesticos;
  }
}