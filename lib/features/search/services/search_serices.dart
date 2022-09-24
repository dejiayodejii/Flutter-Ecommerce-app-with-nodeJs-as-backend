// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pushit/constants/global_variables.dart';
import 'package:pushit/models/product.dart';

class SearchServices {
  String uri = GlobalVariables.uri;

  Future<dynamic> searchedProduct({
    required String token,
    required String searchQuery,
  }) async {
    http.Response res = await http.get(
      Uri.parse('$uri/api/products/search/$searchQuery'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
    );
    List body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      print('herrrere');
      return Future.value(
          body.map((e) => ProductModel.fromJson(jsonEncode(e))).toList());
    } else {
      print('heeeeere');
      return Future.error(res);
    }
  }
}
