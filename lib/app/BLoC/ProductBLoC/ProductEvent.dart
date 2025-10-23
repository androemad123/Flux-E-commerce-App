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

class AddProduct extends ProductEvent {
  final String ProductName;
  final String ProductDescription;
  final List<String> ProductImageURL;
  // String ProductCategotry;
  final double ProductPrice;
  final int ProductQuantity;
  AddProduct(
      {required this.ProductName,
      required this.ProductDescription,
      // required this.ProductCategotry,
      required this.ProductPrice,
      required this.ProductImageURL,
      required this.ProductQuantity});
  @override
  List<Object?> get props => [
        ProductName,
        ProductDescription,
        ProductImageURL,
        ProductPrice,
        ProductQuantity
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

class LoadSpecificProduct extends ProductEvent {
  final String field;
  final dynamic isEqualTo;
  LoadSpecificProduct({required this.field, required this.isEqualTo});

  @override
  List<Object?> get props => [field , isEqualTo];

}
