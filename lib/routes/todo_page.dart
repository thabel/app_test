import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class Todo {
  // here we define data structure of Todo
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

class TodoCache {
  var _index = -1;
  final List<Todo> _todos = [
    Todo("Item 1", "First to-do of the list"),
    Todo("Item 2", "Second to-do of the list"),
    Todo("Item 3", "Third to-do of the list"),
  ];
  void addItem(String title, String descr) {
    _todos.add(Todo(title, descr));
  }

  int get index => _index;
  set index(int value) {
    if ((value >= 0) && (value < _todos.length)) {
      _index = value;
    } else {
      _index = -1;
    }
  }

  UnmodifiableListView<Todo> get list => UnmodifiableListView<Todo>(_todos);
}

class TodoPage extends StatelessWidget {
  final List<Todo> todos = const [
    Todo("Item 1", "First to-do of the list"),
    Todo("Item 2", "Second to-do of the list"),
    Todo("Item 3", "Third to-do of the list"),
  ];

  const TodoPage({super.key});


  void _open(BuildContext context){
Navigator.of(context).pushNamed(RouteGenerator.infoPage);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Todo Page"),
      ),
      body: Consumer<TodoCache>(
        builder:  (context, cache, _) {
          return  ListView.builder(
            itemCount: cache.list.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cache.list[index].title),
                onTap: () {
                  cache.index = index;
                  _open(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Info Page"),
      ),
      body: 
    Consumer<TodoCache>(
   
      builder: (context, cache , _) {
        if (kDebugMode) {
          print("builder ${cache.list}");
        }
        final item = cache.list[cache.index];
        return Center(child: Text(item.description));
      }
    ));
  }
}
