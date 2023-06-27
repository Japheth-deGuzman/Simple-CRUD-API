import 'package:codemydotcom/models/models.dart';
import 'package:codemydotcom/operation/methods.dart';
import 'package:flutter/foundation.dart';

class DataClass extends ChangeNotifier {
  List<User>? post;
  bool isLoaded = false;
  Future<void> getpostdata() async {
    post = await Methods().get('users');

    isLoaded = true;
    notifyListeners();
  }
}
