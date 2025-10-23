class Product {
  
  String ProductID;
  String ProductName;
  String ProductDescription;
  // String ProductCategotry;
  List<String>? ProductColors;
  List<String>? ProductSizes;
  double ProductPrice;
  List<String> ProductImageURL;
  int ProductQuantity;
  // bool isProductBuyed;

  Product({
    required this.ProductID,
    required this.ProductName,
    required this.ProductDescription,
    // required this.ProductCategotry,
    this.ProductColors,
    this.ProductSizes,
    required this.ProductPrice,
    required this.ProductImageURL,
    required this.ProductQuantity,
    // required this.isProductBuyed
  });

  Map<String, dynamic> tojson() {
    return {
      'ProductID': ProductID,
      'ProductName': ProductName,
      'ProductDescription': ProductDescription,
      // 'ProductCategotry': ProductCategotry,
      'ProductColors': ProductColors,
      'ProductSizes': ProductSizes,
      'ProductPrice': ProductPrice,
      'ProductImageURL': ProductImageURL,
      'ProductQuantity': ProductQuantity,
      // 'isProductBuyed': isProductBuyed,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      ProductID: json['ProductID'] ?? "No ID",
      ProductName: json['ProductName'] ?? 'No Product Name',
      ProductDescription:
          json['ProductDescription'] ?? 'No Product description',
      //  ProductCategotry: json['ProductCategotry'] ?? 'No Product category',
      ProductColors: json['ProductColors'] ?? [],
      ProductSizes: json['ProductSizes'] ?? [],
      ProductPrice: json['ProductPrice'] ?? 0.00,
      ProductImageURL: json['ProductImageURL'] ?? [],
      ProductQuantity: json['ProductQuantity'] ?? 0,
      // isProductBuyed: json['isProductBuyed'] ?? false,
    );
  }
  // Helpful for updating fields without rebuilding everything
  Product copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? colors,
    List<String>? sizes,
    double? price,
    List<String>? imageUrl,
    int? quantity,
  }) {
    return Product(
      ProductID: id ?? this.ProductID,
      ProductName: name ?? this.ProductName,
      ProductDescription: description ?? this.ProductDescription,
      ProductColors: colors ?? this.ProductColors,
      ProductSizes: sizes ?? this.ProductSizes,
      ProductQuantity: quantity ?? this.ProductQuantity,
      ProductPrice: price ?? this.ProductPrice,
      ProductImageURL: imageUrl ?? this.ProductImageURL,
    );
  }
}
