import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'stories_bloc.dart';
import 'stories_provider.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({required Key key, required Widget child})
          : bloc = StoriesBloc(),
          super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static of(context) {}
}

 

 StoriesBloc of(BuildContext context) {
  return (context.dependOnInheritedWidgetOfExactType(aspect: StoriesProvider) as StoriesProvider).bloc;
}