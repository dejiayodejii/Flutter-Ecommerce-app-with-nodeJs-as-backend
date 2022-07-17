// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pushit/models/product.dart';

class AdminService {
  String uri = 'http://192.168.1.18:3000';

  Future<dynamic> addProduct(
      {required ProductModel product, required String token}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        body: product.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      if (res.statusCode == 200) {
        return Future.value(ProductModel.fromJson(res.body));
      } else {
        return Future.error(res);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getAllProduct(String token) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      if (res.statusCode == 200) {
        List body = jsonDecode(res.body);
        return Future.value(body.map((e) => ProductModel.fromJson(jsonEncode(e))).toList());
      } else {
        return Future.error(res);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }


    Future<dynamic> deleteProduct({required String token,required ProductModel product}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/get-products'),
         body: jsonEncode({
          'id': product.id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      if (res.statusCode == 200) {
        return Future.value(ProductModel.fromJson(res.body));
      } else {
        return Future.error(res);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
