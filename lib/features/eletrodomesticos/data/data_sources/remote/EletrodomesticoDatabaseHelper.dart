import 'dart:async';
import 'dart:io';
import 'package:gerenciamento_energia_bloc/features/eletrodomesticos/data/models/EletrodomesticoModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class EletroDatabaseHelper {

  static EletroDatabaseHelper? _eletroDatabaseHelper;
  static Database? _database;
  String eletrodomesticoTable = 'eletrodomesticoTable';
  String id = 'id';
  String name = 'name';
  String wattshora = 'wattshora';
  String consumoDeclarado = 'consumoDeclarado';
  String consumoEstimado = 'consumoEstimado';

  EletroDatabaseHelper._createInstance();

  factory EletroDatabaseHelper() {
    if (_eletroDatabaseHelper == null) {
      _eletroDatabaseHelper = EletroDatabaseHelper._createInstance();
    }
    return _eletroDatabaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'eletrodomesticos_database.db';
    var eletroDatabase = await openDatabase(
        path, version: 1, onCreate: _createTable);
    print("Database criada");
    return eletroDatabase;
  }

  void _createTable(Database db, int newVersion) async {
    if (_database == null) {
      await db.execute(
          'CREATE TABLE $eletrodomesticoTable('
              '$id INTEGER PRIMARY KEY, $name TEXT, voltagem TEXT, $wattshora TEXT, $consumoDeclarado TEXT, $consumoEstimado TEXT)'
      );
    }
  }

  // Crud

  // Future<EletrodomesticoModel> getEletrodomestico(int id) async {
  //   Database db = await this.database;
  //   var eletrodomesticos = await db.rawQuery(
  //       'SELECT * FROM $eletrodomesticoTable WHERE $id = \'$id\' '
  //   );
  //   return eletrodomesticos;
  // }

  Future<List<Map<String, dynamic>>> getAllEletrodomesticos(int id) async {
    Database db = await this.database;
    var eletrodomesticos = await db.rawQuery(
        'SELECT * FROM $eletrodomesticoTable WHERE $id = \'$id\' '
    );
    return eletrodomesticos;
  }

  Future<int> insertEletro(EletrodomesticoModel eletro) async {
    Database db = await this.database;
    var eletrodomesticos = await db.insert(
        eletrodomesticoTable, eletro.toMap());
    print("eletro $eletro inserted in $eletrodomesticoTable");
    return eletrodomesticos;
  }

  Future<int> updateEletro(EletrodomesticoModel eletro) async {
    Database db = await this.database;
    var eletrodomesticos = await db.update(
        eletrodomesticoTable, eletro.toMap(),
        where: '$id = ?',
        whereArgs: [eletro.id]
    );
    return eletrodomesticos;
  }

  Future<int> deleteEletro(int id) async {
    Database db = await this.database;
    var eletrodomesticos = await db.rawDelete(
        'DELETE * FROM $eletrodomesticoTable WHERE $id = ?', [id]
    );
    return eletrodomesticos;
  }
}
