class Product {
  int ProductID;
  String ProductName;
  String ProductDescription;
  String ProductCategotry;
  double ProductPrice;
  String ProductImageURL;
  int ProductQuantity;
  int ProductUserQuantity;
  bool isProductFavourate;
  bool isProductInCart;
  bool isProductBuyed;

  Product(
      {required this.ProductID,
      required this.ProductName,
      required this.ProductDescription,
      required this.ProductCategotry,
      required this.ProductPrice,
      required this.ProductImageURL,
      required this.ProductQuantity,
      required this.ProductUserQuantity,
      required this.isProductFavourate,
      required this.isProductInCart,
      required this.isProductBuyed});
}

class ProductState {
  final List<Product> product;
  ProductState({required this.product});

  ProductState copyWith({List<Product>? product}) {
    return ProductState(product: product ?? this.product);
  }
}
