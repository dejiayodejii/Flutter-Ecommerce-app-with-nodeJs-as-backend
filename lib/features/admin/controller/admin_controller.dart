// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pushit/constants/utils.dart';
import 'package:pushit/features/admin/services/admin_services.dart';
import 'package:pushit/models/product.dart';
import 'package:pushit/provider/user_provider.dart';

class AdminController {
  final cloudinary =
      CloudinaryPublic('dynsuyth4', 'xggouulm', cache: false);

  final AdminService _adminService = AdminService();
  List<ProductModel> productList = [];

  Future<void> addProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required String category,
      required double price,
      required double quantity,
      required List<File> images}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrl.add(res.secureUrl);
      }

      ProductModel product = ProductModel(
          name: name,
          category: category,
          description: description,
          images: imageUrl,
          quantity: quantity,
          price: price);

      ProductModel res = await _adminService.addProduct(
          product: product, token: userProvider.getUser.token);
      print(res.toString());
      showSnackBar(context, 'Product Added Successfully!');
    } on Exception catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getAllProduct(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    _adminService.getAllProduct(userProvider.getUser.token).then((value) {
      print(value);
      productList.addAll(value);
    }).catchError((e) {
      print(e.toString());
    });
  }

    void deleteProduct(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    _adminService.getAllProduct(userProvider.getUser.token).then((value) {
      print(value);
      showSnackBar(context, 'Product deleted Successfully!');
    }).catchError((e) {
      print(e.toString());
    });
  }
}
