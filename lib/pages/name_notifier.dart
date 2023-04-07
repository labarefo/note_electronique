
import 'package:flutter/foundation.dart';

class NameNotifier extends ChangeNotifier {

  bool _filled = false;

  set filled(bool value) {
    _filled = value;
    notifyListeners();
  }

  bool get filled => _filled;


}