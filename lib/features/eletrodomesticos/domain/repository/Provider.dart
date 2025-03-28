

import 'package:flutter/cupertino.dart';
import 'package:gerenciamento_energia_bloc/features/eletrodomesticos/data/models/EletrodomesticoModel.dart';

class ItemProvider with ChangeNotifier {
  List<EletrodomesticoModel> _items = [];

  List<EletrodomesticoModel> get items => _items;

  Future<void> fetchItems() async {
    final dbHelper = DatabaseHelper();
    final data = await dbHelper.getItems();
    _items = data.map((map) => Item.fromMap(map)).toList();
    notifyListeners();
  }
}