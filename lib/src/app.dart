import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return CommentProvider(
      key: const ValueKey("itemParent"),
      child: StoriesProvider(
        key: const ValueKey("item"),
        child:  MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);

          storiesBloc.fetchTopIds();
          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentProvider.of(context);
          final itemId = int.parse(settings.name!.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);


          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
    
  }
  
  //MaterilaApp({required String title, NewsList? home, required Route Function(RouteSettings settings) onGenerateRoute}) {}
}