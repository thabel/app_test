import 'package:app_test/routes/todo_page.dart';
import 'package:app_test/web_view.dart';
import 'package:flutter/material.dart';

import 'routes/home_page.dart';
import 'routes/random_page.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String randomPage = '/random';
  static const String todoPage = '/todoPage';
  static const String infoPage = "/infoPage";
  static const String webView = "/webview";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //4.
    switch (settings.name) {
      case homePage:
        // .5
        return MaterialPageRoute(builder: (_) => const HomePage());
      case randomPage:
        return MaterialPageRoute(builder: (_) => const RandomPage());
      case todoPage : 
         return MaterialPageRoute(builder: (_) =>
         
          const TodoPage()
          );
      case infoPage:
         return MaterialPageRoute(builder: (_) =>
         
          const InfoPage()
          );
      case webView:
          return (MaterialPageRoute(builder: (_) => const WebViewPage()));

      default:
        throw FormatException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}

