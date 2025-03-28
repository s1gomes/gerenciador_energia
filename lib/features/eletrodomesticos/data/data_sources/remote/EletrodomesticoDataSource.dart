import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gerenciamento_energia_bloc/features/eletrodomesticos/data/models/EletrodomesticoModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// class ItemProvider with ChangeNotifier{
  // WidgetsFlutterBinding.ensureInitialized();

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
  final database = openDatabase(
    join(await getDatabasesPath(), 'eletrodomesticos_database.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE eletrodomesticos('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, voltagem TEXT, '
      'wattshora TEXT, '
      'consumoDeclarado TEXT, '
      'consumoEstimado TEXT)',
      );
    },
    version: 1
  );

  Future<void> insertEletrodomestico(EletrodomesticoModel eletrodomestico) async {
    final db = await database;
    await db.insert(
        'eletrodomesticos',
        eletrodomestico.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<EletrodomesticoModel>> allEletrodomesticos() async {
    final db = await database;

    final List<Map<String, Object?>> eletroMaps = await db.query('eletrodomesticos');

    return [
      for (final {
      'id': id as int, 'name': name as String, 'voltagem': voltagem as String, 'wattshora': wattshora as String, 'consumoDeclarado': consumoDeclarado as String, 'consumoEstimado': consumoEstimado as String
      } in eletroMaps)
        EletrodomesticoModel(id: id, name: name, voltagem: voltagem, wattshora: wattshora, consumoDeclarado: consumoDeclarado, consumoEstimado: consumoEstimado),
    ];
  }

  Future<void> updateEletrodomestico(EletrodomesticoModel eletro) async {
    final db = await database;

    await db.update(
      'eletrodomesticos',
      eletro.toMap(),
      where: 'id = ?',
      whereArgs: [eletro.id]
    );
  }

  Future<void> deleteEletrodomestico(int id) async {
    final db = await database;
    await db.delete(
      'eletrodomesticos',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}