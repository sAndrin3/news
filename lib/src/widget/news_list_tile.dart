import'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news/src/widget/loading_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_container.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsListTile extends StatelessWidget {
  final int itemId;
  Client client = Client();

  NewsListTile({required this.itemId});

  @override
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (! snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data![itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (! itemSnapshot.hasData) {
              return LoadingContainer();
            }

            var data = itemSnapshot.data;
            return buildTile(context, itemSnapshot.data!);
          },
        );

      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {

    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}')
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}