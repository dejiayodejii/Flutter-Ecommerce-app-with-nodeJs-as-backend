// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pushit/constants/global_variables.dart';
import 'package:pushit/models/product.dart';

class HomeService {
  String uri = GlobalVariables.uri;

  productByCategory(String category, String token) async {
    http.Response response = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'Application/json, charset=UTF-8',
          'x-auth-token': token
        });
    print('jjeie');
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('222');
       print('statuss code ${response.statusCode}');
      return Future.value(
          body.map((e) => ProductModel.fromJson(jsonEncode(e))).toList());
    } else {
      print('1111');
      print('status code ${response.statusCode}');
      return Future.error(response);
    }
  }

  rateProduct(ProductModel product, String token, double rating) async {
    http.Response response = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );
    //var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Future.value(
         ProductModel.fromJson(response.body));
    } else {
      print('1111');
      print('status code ${response.statusCode}');
      return Future.error(response);
    }
  }





}
