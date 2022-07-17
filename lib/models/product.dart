import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String name;
  final String category;
  final String? id;
  final String description;
  final List<String> images;
  final double quantity;
  final double price;
  
  ProductModel({
    required this.name,
    required this.category,
     this.id,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,

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
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      category: map['category'] as String,
      id: map['_id'] != null ? map['id'] as String : null,
      description: map['description'] as String,
      images: List<String>.from((map['images'] as List<String>)),
      quantity: map['quantity'] as double,
      price: map['price'] as double,
    
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
