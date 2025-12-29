import 'package:app_test/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.randomPage);
              },
              child: const Text("Random"),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.todoPage);
              },
              child: const Text("Todo List"),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.webView);
              },
              child: const Text("Web View"),
            ),
          ],
        ),
      ),
    );
  }
}
