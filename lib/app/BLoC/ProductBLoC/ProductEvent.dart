import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final String ProductID;
  LoadProduct({required this.ProductID});
  @override
  List<Object?> get props => [ProductID];
}

class LoadSpecificProduct extends ProductEvent {
  final String field;
  final dynamic isEqualTo;
  LoadSpecificProduct({required this.field, required this.isEqualTo});

  @override
  List<Object?> get props => [field, isEqualTo];
}

class LoadCategoryProduct extends ProductEvent {
  final String ProductCategotry;
  LoadCategoryProduct({required this.ProductCategotry});

  @override
  List<Object?> get props => [ProductCategotry];
}

////////////////////////////////
class AddProduct extends ProductEvent {
  final String ProductName;
  final String ProductDescription;
  final List<String> ProductImageURL;
  final String? ProductCategotry;
  final double ProductPrice;
  final int ProductQuantity;
  final List<String>? ProductColors;
  final List<String>? ProductSizes;
  final String? ProductID; // Optional, will be generated if not provided
  
  AddProduct({
    required this.ProductName,
    required this.ProductDescription,
    this.ProductCategotry,
    required this.ProductPrice,
    required this.ProductImageURL,
    required this.ProductQuantity,
    this.ProductColors,
    this.ProductSizes,
    this.ProductID,
  });
  
  @override
  List<Object?> get props => [
        ProductName,
        ProductDescription,
        ProductImageURL,
        ProductCategotry,
        ProductPrice,
        ProductQuantity,
        ProductColors,
        ProductSizes,
        ProductID,
      ];
}

class DeleteProduct extends ProductEvent {
  final int ProductID;
  DeleteProduct({required this.ProductID});
  @override
  List<Object?> get props => [ProductID];
}

class AdminEditProduct extends ProductEvent {
  // final String ProductID;
  final String? ProductName;
  final String? ProductDescription;
  // final String? ProductCategotry;
  final double? ProductPrice;
  final String? ProductImageURL;
  final int? ProductQuantity;

  AdminEditProduct(
      {
      //required this.ProductID,
      this.ProductName,
      this.ProductDescription,
      // this.ProductCategotry,
      this.ProductPrice,
      this.ProductImageURL,
      this.ProductQuantity});
  @override
  List<Object?> get props => [
        ProductName,
        ProductDescription,
        ProductPrice,
        ProductImageURL,
        ProductQuantity
      ];
}
