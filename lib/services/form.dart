import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:pfe_project/services/dio.dart';
import 'package:pfe_project/services/user.dart';
import 'package:http/http.dart' as http;

class SendForm extends ChangeNotifier {
  send(Map creds, token) async {
    try {
      Dio.Response response = await dio().post('/send_form',
          data: creds,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

      var jsonData = response.data;
      print(jsonData.toString());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  } 

  getData(token)async{
  var url = Uri.parse('http://127.0.0.1:8000/forms'); // API endpoint URL

  var headers = {
    'Authorization': 'Bearer $token', // Replace with your bearer token
  };

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // Request was successful
    var responseData = response.body;
    // Process the response data here
    print(responseData);
  } else {
    // Request failed
    print('Request failed with status code ${response.statusCode}');
  }
  
}


}
