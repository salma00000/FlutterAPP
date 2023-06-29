import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:pfe_project/services/dio.dart';
import 'package:pfe_project/services/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Products extends ChangeNotifier {
  List? _products;

  list(String? token) async {
    try {
      Dio.Response response = await dio().get('/products',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      var jsonData = response.data;
      print(jsonData);
      List<String> products = [];
      
      jsonData.forEach((element) {
        products.add(element[0]['nom_produit']);
      });

      return products;
    } catch (e) {
      print(e);
    }
  }
}
