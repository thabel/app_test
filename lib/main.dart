
import 'package:app_test/routes/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp() ;

  @override
  Widget build(BuildContext context) {
    return Provider<TodoCache>(
      create: (context) => TodoCache(),
      child:MaterialApp(
      onGenerateTitle: (context) => "Ramdom App",
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute:  RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    )
    );
  }
}