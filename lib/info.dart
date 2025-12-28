import 'package:flutter/foundation.dart';

class Info extends ChangeNotifier {
  int _currentIndex = 0;
  final _texts = [
    "Every thing na double double",
    "The king of God is good",
    "Look at your childhood",
  ];

  String getText() {
    return _texts[(_currentIndex++) % _texts.length];
  }

  void  change() {
      _currentIndex++;
      notifyListeners();
  }
}
