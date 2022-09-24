// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pushit/features/home/services/home_service.dart';
import 'package:pushit/models/product.dart';
import 'package:pushit/provider/user_provider.dart';

class HomeController {
  final HomeService _homeService = HomeService();

  List<ProductModel>? products;

  getProductByCategory(String category, BuildContext context,
      {required Function onSucces, required Function onError}) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _homeService
        .productByCategory(category, userProvider.getUser.token)
        .then((value) {
      products = value;
      onSucces();
    }).catchError((e) {
      print(e.toString());
      onError(e.toString());
    });
  }

  rateProduct(ProductModel product, BuildContext context, double rating,
      ) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _homeService
        .rateProduct(product, userProvider.getUser.token, rating)
        .then((value) {
      //onSucces();
    }).catchError((e) {
      print(e.toString());
     // onError(e.toString());
    });
  }




}
