// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pushit/features/auth/model/usermodel.dart';

class AuthService {
  String uri = 'http://192.168.1.18:3000';

  Future<dynamic> signUp(User user) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signUp'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return Future.value(body);
      } else {
        return Future.error(res);
      }
    } on Exception catch (e) {
      print(e.toString());
      //i need to catch if there is an error when making the request either timeout or socket
      //this error is for if the post request did not go through at all
    }
  }

  Future<dynamic> signIn(
      {required String password, required String email}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        return Future.value(User.fromJson(res.body));
      } else {
        return Future.error(res);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> validateToken(String token) async {
    try {
      var tokenRes = await http.post(
        Uri.parse('$uri/api/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getData(String token) async {
    try {
      bool res = await validateToken(token);
      if (res) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/api/getUserData'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        if (userRes.statusCode == 200) {
          return Future.value(User.fromJson(userRes.body));
        } else {
          return Future.error(userRes);
        }
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        //treat SocketException
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        //treat TimeoutException
        print("Timeout exception: ${e.toString()}");
      } else {
        print("Unhandled exception: ${e.toString()}");
      }
    }
  }
}
