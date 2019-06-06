import 'dart:io';

import 'package:WorkTowards/src/model/item.dart';
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

  insertItem(Item item) async {
    ObjectDB database = await db;
    database.insert({'title': item.title, 'price': item.price, 'taxRate': item.taxRate, 'includeTax': item.includeTax });
  }

  Future<List<Map<dynamic, dynamic>>> getItemById(String id) async {
    ObjectDB database = await db;
    return await database.find({'_id': id});
  }

  Future<List<Map<dynamic, dynamic>>> getAllItems() async {
    ObjectDB database = await db;
    // await clearAllItems();
    return await database.find({});
  }

  Future<bool> clearAllItems() async {
    ObjectDB database = await db;
    await database.remove({});
    return true;
  }

  close() async {
    ObjectDB database = await db;
    await database.tidy();
    await database.close();
  }
}
