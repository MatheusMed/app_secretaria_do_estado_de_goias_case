import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ServiceDb {
  ServiceDb._();
  static final ServiceDb instance = ServiceDb._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatase();
  }

  Future<Database> _initDatase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cadastro.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
       CREATE TABLE cadastro(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cpf TEXT NOT NULL,
    dataDeNasc TEXT NOT NULL,
    login TEXT NOT NULL,
    senha TEXT NOT NULL
);
      ''',
    );
  }
}
