import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:github_demo/Models/user_model.dart';
import 'package:github_demo/Requests/api_repo.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;
  String? errorMessage;
  bool loading = false;

  Future<bool> fetchUser(username) async {
    setLoading(true);

    await ApiRepo(username).fetchUser().then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(UserModel.fromJson(json.decode(data.body)));
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });
    notifyListeners();

    return isUser();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  UserModel getUSer() {
    return user!;
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage ?? "";
  }

  bool isUser() {
    return user != null ? true : false;
  }
}
