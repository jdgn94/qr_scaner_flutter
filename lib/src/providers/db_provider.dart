import 'dart:io';

import 'package:qr_scaner/src/models/scan_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    return _database = await initDB();
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE Scans ('
        ' id INTEGER PRIMARY KEY,'
        ' type TEXT,'
        ' value TEXT'
        ')',
      );
    });
  }

  // Insert tradicional
  newScanRaw(ScanModel newScan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES (${newScan.id}, '${newScan.type}', '${newScan.value}')",
    );
    return res;
  }
  // NOTA: Todos los metodos titen el raw que simplemente es la forma tradicional haciendo el query a mano

  // Insert simplificado
  newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());

    return res;
  }

  // Get
  Future<ScanModel> getScan(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
        ? res.map((item) => ScanModel.fromJson(item)).toList()
        : [];

    return list;
  }

  Future<List<ScanModel>> getScansType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    List<ScanModel> list = res.isNotEmpty
        ? res.map((item) => ScanModel.fromJson(item)).toList()
        : [];

    return list;
  }

  // Update
  Future<int> updateScan(ScanModel values) async {
    final db = await database;
    final res = await db.update('Scans', values.toJson(),
        where: 'id = ?', whereArgs: [values.id]);

    return res;
  }

  //Delete
  deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');

    return res;
  }

  deleteAllTypeScans(String type) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'type = ?', whereArgs: [type]);
  }
}
