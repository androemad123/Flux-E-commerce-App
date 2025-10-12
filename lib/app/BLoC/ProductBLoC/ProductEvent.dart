abstract class ProductEvent {}

class LoadAllProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final String ProductID;
  LoadProduct({required this.ProductID});
}

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

class AdminEditProduct extends ProductEvent {
  final String ProductID;
  final String? ProductName;
  final String? ProductDescription;
  final String? ProductCategotry;
  final double? ProductPrice;
  final String? ProductImageURL;
  final int? ProductQuantity;

  AdminEditProduct(
      {required this.ProductID,
      this.ProductName,
      this.ProductDescription,
      this.ProductCategotry,
      this.ProductPrice,
      this.ProductImageURL,
      this.ProductQuantity});
}

class LoadCategoryProduct extends ProductEvent {
  String ProductCategotry;
  LoadCategoryProduct({required this.ProductCategotry});
}
