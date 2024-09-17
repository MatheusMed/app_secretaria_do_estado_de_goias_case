import 'package:app_cadastro_goiais/src/models/cadastro_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../services/service_db.dart';

class CadastroController {
  final listaUsuarios = ValueNotifier(<CadastroModel>[]);
  final osbcureText = ValueNotifier(true);

  late Database _database;

  Future<List<CadastroModel>> getAllUsers() async {
    _database = await ServiceDb.instance.database;
    var aliement = await _database.query('cadastro', orderBy: 'id');
    listaUsuarios.value = aliement.isNotEmpty
        ? aliement.map((model) => CadastroModel.fromMap(model)).toList()
        : [];

    return listaUsuarios.value;
  }

  Future<int> addUser(CadastroModel model) async {
    _database = await ServiceDb.instance.database;
    return await _database.insert('cadastro', model.toMap());
  }

  Future<CadastroModel?> getCadastro(int id) async {
    _database = await ServiceDb.instance.database;

    var result = await _database.query(
      'cadastro',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    // Verifica se encontrou algum registro
    if (result.isNotEmpty) {
      return CadastroModel.fromMap(result.first);
    }

    return null;
  }

  int? obterIdPeloLogin(String login) {
    CadastroModel? cadastro = listaUsuarios.value.firstWhere(
      (cadastro) => cadastro.login == login,
    );

    return cadastro.id;
  }
}
