// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushit/features/search/services/search_serices.dart';
import 'package:pushit/models/product.dart';
import 'package:pushit/provider/user_provider.dart';

class SearchController {
  final SearchServices _searchService = SearchServices();

  List<ProductModel>? searchProductList;

  void fetchSearchedProduct(BuildContext context, Function onSuccess, String searchQuery) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print('one');
    _searchService.searchedProduct(token:userProvider.getUser.token,searchQuery:  searchQuery ).then((value) {
      print('twoo');
      searchProductList = value;
      onSuccess();
    }).catchError((e) {
      print(e.toString());
    });
  }
}
