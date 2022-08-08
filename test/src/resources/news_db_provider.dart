import 'package:news/src/models/item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'repository.dart';
import '../models/item_model.dart';
import 'repository.dart';


class NewsDbProvider implements Source, Cache {
  Database ?db;

  NewsDbProvider() {
    init();
  }

// Todo -store and fetch top ids
  Future<List<int>?>? fetchTopId() {
    return null;
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items4.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      },
    );

  }

   Future<ItemModel?>fetchItems(int id) async {
    final maps = await db?.query(
     "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps!.length > 0) {
      return ItemModel.fromDb(maps.first);
    } 

    return null;
  }

  Future<int>?addItems(ItemModel item) {
    return db?.insert(
      "Items",
      item.toMapForDb()
      conflictAlgorithm: ConflictAlgorithm.ignore,
      );
  }

  Future <int>? clear() {
    return db?.delete("Items");
  }
  
  @override
  // TODO: implement fetchTopIds
  Future<List<int>> get fetchTopIds async => throw UnimplementedError();
  
  @override
  Future<int> addItem(ItemModel item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }
  
  @override
  Future<itemModel> fetchItem(int id) {
    // TODO: implement fetchItem
    throw UnimplementedError();
  }
} 

final newsDbProvider = NewsDbProvider();