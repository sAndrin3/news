import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentProvider extends InheritedWidget {
  final CommentsBloc bloc;

CommentProvider({required Key key, Widget? child})
  : bloc = CommentsBloc(),
  super(key: key, child: child!);

@override
bool updateShouldNotify(oldWidget) => true;

static CommentsBloc of(BuildContext context) {
  return (context.dependOnInheritedWidgetOfExactType<CommentProvider>())!.bloc;
}
}

// class CommentsProvider {
// }