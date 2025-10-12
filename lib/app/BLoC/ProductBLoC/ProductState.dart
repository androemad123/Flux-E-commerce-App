import 'package:flutter/material.dart';

class Product {
  String ProductID;
  String ProductName;
  String ProductDescription;
  String ProductCategotry;
  List<MaterialColor> ProductColors;
  List<String> ProductSizes;
  double ProductPrice;
  String ProductImageURL;
  int ProductQuantity;
  bool isProductBuyed;

  Product(
      {required this.ProductID,
      required this.ProductName,
      required this.ProductDescription,
      required this.ProductCategotry,
      required this.ProductColors,
      required this.ProductSizes,
      required this.ProductPrice,
      required this.ProductImageURL,
      required this.ProductQuantity,
      required this.isProductBuyed});

  Map<String, dynamic> tojson() {
    return {
      'ProductID': ProductID,
      'ProductName': ProductName,
      'ProductDescription': ProductDescription,
      'ProductCategotry': ProductCategotry,
      'ProductColors': ProductColors,
      'ProductSizes': ProductSizes,
      'ProductPrice': ProductPrice,
      'ProductImageURL': ProductImageURL,
      'ProductQuantity': ProductQuantity,
      'isProductBuyed': isProductBuyed,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      ProductID: json['ProductID'] ?? "",
      ProductName: json['ProductName'] ?? 'No Product Name',
      ProductDescription:
          json['ProductDescription'] ?? 'No Product description',
      ProductCategotry: json['ProductCategotry'] ?? 'No Product category',
      ProductColors: json['ProductColors'] ?? [],
      ProductSizes: json['ProductSizes'] ?? [],
      ProductPrice: json['ProductPrice'] ?? 0.00,
      ProductImageURL: json['ProductImageURL'] ?? '',
      ProductQuantity: json['ProductQuantity'] ?? 0,
      isProductBuyed: json['isProductBuyed'] ?? false,
    );
  }
}

// class ProductsLoaded extends ProductState {
//   final List<Product> products;
//   ProductsLoaded({required this.products}) : super(product: []);
// }

// class ProductLoaded extends ProductState {
//   final Product prod;
//   ProductLoaded({required this.prod}) : super(product: []);
// }

class ProductState {
  final List<Product> product;
  ProductState({required this.product});

  ProductState copyWith({List<Product>? product}) {
    return ProductState(product: product ?? this.product);
  }
}
