import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:pfe_project/services/dio.dart';
import 'package:pfe_project/services/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user;
  String? _token;

  bool get authenticated => _isLoggedIn;

  User? get user => _user;

  String? get token => _token;

  final storage = new FlutterSecureStorage();

  void login(Map creds) async {
    try {
      Dio.Response response = await dio().post('/sanctum/token', data: creds);


      String token = response.data.toString();
      String tokenWithoutSpaces = token.replaceAll('\n\n\n', '');

      print('token from auth');
      print(tokenWithoutSpaces);
      this.tryToken(token: tokenWithoutSpaces);
      _isLoggedIn = true;


      this.storeToken(token: token);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void storeToken({String? token}) async {
    this.storage.write(key: 'token', value: token);
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void tryToken({String? token}) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await dio().get('/user',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

        this._isLoggedIn = true;
        this._user = User.fromJson(response.data);
        this._token = token;

        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }
}
