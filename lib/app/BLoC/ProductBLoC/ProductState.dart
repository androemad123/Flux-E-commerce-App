import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:equatable/equatable.dart';


abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class initialState extends ProductState {
  final List<Product> products;
  initialState({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductLoading extends ProductState {}

class AllProductsLoaded extends ProductState {
  final List<Product?> products;
  AllProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class SpecificProducts extends ProductState{
   final List<Product?> products;
  SpecificProducts({required this.products});

  @override
  List<Object?> get props => [products];

}

class ProductLoaded extends ProductState {
  final Product product;
  ProductLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

class ErrorState extends ProductState {
  final String errorMSG;
  ErrorState({required this.errorMSG});

   @override
  List<Object?> get props => [errorMSG];

}
