import 'dart:async';

import 'package:qr_scaner/src/providers/db_provider.dart';

class ScansBlock {
  static final ScansBlock _singleton = new ScansBlock._();

  factory ScansBlock() {
    return _singleton;
  }

  ScansBlock._() {
    // Aqui se obtendra la data al iniciar la aplicacion
    getScans();
  }

  final _scansStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansStreamController.stream;

  dispose() {
    _scansStreamController?.close();
  }

  getScans() async {
    _scansStreamController.sink.add(await DBProvider.db.getAllScans());
  }

  addScan(ScanModel value) async {
    await DBProvider.db.newScan(value);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    getScans();
  }

  deleteAllTypeScans(String type) async {
    await DBProvider.db.deleteAllTypeScans(type);
    getScans();
  }
}
