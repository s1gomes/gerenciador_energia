

import '../../data/models/EletrodomesticoModel.dart';

abstract class EletrodomesticoRepository {

  Future<List<Map<String, dynamic>>> getAllEletrodomesticos();

  Future<List<Map<String, dynamic>>> getEletrodomestico(
      int id
  );

  Future<int> insertEletro(
      EletrodomesticoModel eletro
  );

  Future<int> updateEletro(
      EletrodomesticoModel eletro
  );

  Future<int> deleteEletro(
      int id
  );

}