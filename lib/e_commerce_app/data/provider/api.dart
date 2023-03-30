import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:my_cart_express/e_commerce_app/data/model/model.dart';
import 'package:http/http.dart' as http;
// import 'package:meta/meta.dart';

const String baseUrl = 'https://jsonplaceholder.typicode.com/posts/';

class MyApiClient {
  MyApiClient({required this.httpClient});
  final http.Client httpClient;

  Future<List<MyModel>> getAll() async {
    try {
      final http.Response response = await httpClient.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        final List<MyModel> listMyModel = (jsonResponse as List<dynamic>)
            .map((dynamic model) =>
                MyModel.fromJson(model as Map<String, dynamic>))
            .toList();
        // listMyModel.removeRange(2, listMyModel.length);
        // List<MyModel> listMyModel = new List<MyModel>.empty();
        return listMyModel;
      } else {
        if (kDebugMode) {
          print('erro');
        }
        return <MyModel>[];
      }
    } on Exception catch (_) {
      return <MyModel>[];
    }
  }

  Future<void> getId(String id) async {
    try {
      final http.Response response = await httpClient.get('baseUrlid' as Uri);
      if (response.statusCode == 200) {
        //Map<String, dynamic> jsonResponse = json.decode(response.body);
      } else if (kDebugMode) {
        print('erro -get');
      }
    } on Exception catch (_) {
      if (kDebugMode) {
        print('erro $_');
      }
    }
  }
}
