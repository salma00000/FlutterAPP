import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:pfe_project/services/dio.dart';
import 'package:pfe_project/services/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Chat extends ChangeNotifier {
  String? _answer;
  bool isMatched = false;

  list(String? token, String? text) async {

    try {

      String tokenWithNewlines = 'Bearer ' + token.toString();
      String tokenWithoutNewlines = tokenWithNewlines.replaceAll('\n', '');

      Dio.Response response = await dio().get('/chatbot',
          options: Dio.Options(headers: {'Authorization': tokenWithoutNewlines}));

      var jsonData = response.data;
      print(jsonData);
      for (var element in jsonData) {
        String questionApi = element['question'];
        String answerApi = element['answer'];

        if (text == "salut" || text == "bonjour" || text == "hello") {
          _answer = 'Salut Bienvenu chez bot assistance!';
          return _answer;
        }

        if (text == "bye") {
          _answer = "Good Bye i hope i helped you !";
          return _answer;
        }

        if (questionApi == text) {
          _answer = answerApi;
          return _answer;
        }
      }

      return "Je n'ai pas pu trouver de réponse. Veuillez remplir ce formulaire afin que nous puissions trouver une solution à votre problème, s'il vous plaît.";
    } catch (e) {
      print(e);
    }
  }
}
