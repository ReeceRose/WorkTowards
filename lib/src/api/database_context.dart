import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseContext {
  // private constuctor
  DatabaseContext._();

  static final DatabaseContext database = DatabaseContext._();

  ObjectDB _database;

  _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = [directory.path, 'work-towards.db'].join('/');
    _database = ObjectDB(path);
    _database.open();
    return _database;
  }

  Future<ObjectDB> get db async {
    return _database == null ? await _initializeDatabase() : _database;
  }

  close() async {
    ObjectDB database = await db;
    await database.tidy();
    await database.close();
  }
}
