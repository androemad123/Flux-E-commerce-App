abstract class ProductEvent {}

class LoadProduct extends ProductEvent {}

class AddProduct extends ProductEvent {
  String ProductName;
  String ProductDescription;
  String ProductCategotry;
  double ProductPrice;
  String ProductImageURL;
  int ProductQuantity;
  AddProduct(
      {required this.ProductName,
      required this.ProductDescription,
      required this.ProductCategotry,
      required this.ProductPrice,
      required this.ProductImageURL,
      required this.ProductQuantity});
}

class DeleteProduct extends ProductEvent {
  final int ProductID;
  DeleteProduct({required this.ProductID});
}

class BuyedProduct extends ProductEvent {
  final int ProductID;
  BuyedProduct({required this.ProductID});
}

class UserProducts extends ProductEvent{
  final int ProductID;
  UserProducts({required this.ProductID});
}

class EditProduct extends ProductEvent {
  final int ProductID;
  final String ProductName;
  final String ProductDescription;
  final String ProductCategotry;
  final double ProductPrice;
  final String ProductImageURL;
  final int ProductQuantity;

  EditProduct(
      {required this.ProductID,
      required this.ProductName,
      required this.ProductDescription,
      required this.ProductCategotry,
      required this.ProductPrice,
      required this.ProductImageURL,
      required this.ProductQuantity});
}

class FavProduct extends ProductEvent {
  final int ProductID;
  FavProduct({required this.ProductID});
}

class CartProduct extends ProductEvent {
  final int ProductID;
  CartProduct({required this.ProductID});
}
