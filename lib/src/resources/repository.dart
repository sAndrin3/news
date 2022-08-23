// TODO Implement this library.
import 'dart:async';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'news_api_provider.dart';
import '../models/item_model.dart';
import 'news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    //NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];
  
  
  // Iterarte over sources when dbprovider get fetchTopIds implemented
  Future<List<int>> fetchTopIds() {
    return sources[0].fetchTopIds;  
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item ;
    Source source;
    item = (await sources[0].fetchItem(id)) as ItemModel;

    for (source in sources) {
      item = (await source.fetchItem(id)) as ItemModel;
      if (item != null) {
        break;
      }
      for (var cache in caches) {
        if (cache != source) {
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

