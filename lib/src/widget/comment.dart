import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

abstract class Comment extends StatelessWidget {
  late final int itemId;
  late final Map<int, Future<ItemModel>> itemMap;
  final int depth;
  
  get kidId => null;

  Comment({required this.itemId, required this.itemMap, required this.depth});

  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if(!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle:item.by == "" ? Text("Deleted") : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0,
            ),
          ),
          Divider(),
        ];
        item.kids.forEach((kidsId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ),);
        });

        return Column (
          children: children,
        );
      },
    );
  }
  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');

    return Text(text);

  }
}