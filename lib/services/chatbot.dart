import 'package:dio/dio.dart' as Dio;
import 'package:pfe_project/services/dio.dart';

class ChatBot {
  String? question;
  String? answer;

  ChatBot({this.question, this.answer});

  ChatBot.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        answer = json['answer'];
}
