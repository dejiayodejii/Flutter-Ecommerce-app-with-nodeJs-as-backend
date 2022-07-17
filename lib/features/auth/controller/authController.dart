// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushit/constants/error_handling.dart';
import 'package:pushit/constants/utils.dart';
import 'package:pushit/features/auth/model/usermodel.dart';
import 'package:pushit/features/auth/services/authservice.dart';
import 'package:pushit/features/home/views/home.dart';
import 'package:pushit/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final AuthService _authService = AuthService();

  bool isLoading = false;

  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    User user = User(
      id: '',
      name: name,
      password: password,
      email: email,
      address: '',
      type: '',
      token: '',
//      cart: [],
    );
    print('hello');
    _authService.signUp(user).then((res) {
      print(res);
      showSnackBar(
        context,
        'Account created! Login with the same credentials!',
      );
    }).catchError((e) {
      httpErrorHandle(
        response: e,
        context: context,
        onSuccess: () {},
      );
    });
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    _authService.signIn(password: password, email: email).then((res) async {
      User user = res;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', user.token);
      Provider.of<UserProvider>(context, listen: false).setUserData = res;
      showSnackBar(
        context,
        'Login Succesfull',
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }).catchError((e) {
      print(e.toString());
    });
  }

  void getData({required BuildContext context}) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    print('token is $token');

    if (token != null) {
      _authService.getData(token).then((value) {
        print(value);
        Provider.of<UserProvider>(context, listen: false).setUserData = value;
      }).catchError((e) {
        print(e.toString());
        // httpErrorHandle(
        //   response: e,
        //   context: context,
        //   onSuccess: () {},
        // );
      });
    }
  }
}
