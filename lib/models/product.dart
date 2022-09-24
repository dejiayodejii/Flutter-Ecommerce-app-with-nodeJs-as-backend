import 'dart:convert';

import 'package:pushit/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String name;
  final String category;
  final String? id;
  final String description;
  final List<String> images;
  final double quantity;
  final double price;
  final List<Rating>? rating;
  
  ProductModel( {
    required this.name,
    required this.category,
     this.id,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,
    required this.rating,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'id': id,
      'description': description,
      'images': images,
      'quantity': quantity,
      'price': price,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
