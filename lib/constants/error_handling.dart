import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pushit/constants/utils.dart';

void httpErrorHandle({
  required Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
   print(response.statusCode);
    print(jsonDecode(response.body)['mesg']);
  switch (response.statusCode) {
   
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['mesg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
