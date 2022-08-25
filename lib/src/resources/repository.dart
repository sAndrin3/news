// TODO Implement this library.
import 'dart:async';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'news_api_provider.dart';
import '../models/item_model.dart';
import 'news_db_provider.dart';

class Repository {
  final newsApiProvider = NewsApiProvider();
  List<Source> sources = <Source>[
    newsDbProvider,
    //newsApiProvider,
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];
  
  
  // Iterarte over sources when dbprovider get fetchTopIds implemented
  Future<List<int>> fetchTopIds() {
    return newsApiProvider.fetchTopIds();  
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item ;
    Source source;
    item = (await newsApiProvider.fetchItem(id));

    for (source in sources) {
      //for (var i = 0; i < 2; i++) {
      item = (await newsApiProvider.fetchItem(id));
      if (item != null) {
        break;
      }
      for (var cache in caches) {
        if (cache != sources) {
          cache.addItem(item);
        }
      }
    }
    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
    
  }
}

abstract class Source {
  Future<List<int>> get fetchTopIds;
  Future<itemModel> fetchItem(int id);
}

class itemModel {
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future <int> clear();
}

class NewsApiProvider1 {
  fetchTopIds() {}
  
  fetchItem(id) {}
}

