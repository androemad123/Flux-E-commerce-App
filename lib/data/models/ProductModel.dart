class Product {
  String ProductID;
  String ProductName;
  String ProductDescription;
  String? ProductCategotry;
  List<String>? ProductColors;
  List<String>? ProductSizes;
  double ProductPrice;
  List<String> ProductImageURL;
  int ProductQuantity;
  // bool isProductBuyed;

  // Placeholder image URLs for missing images
  static const List<String> placeholderImages = [
    'https://via.placeholder.com/300x300?text=No+Image',
    'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=300&h=300&fit=crop',
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=300&h=300&fit=crop',
  ];

  Product({
    required this.ProductID,
    required this.ProductName,
    required this.ProductDescription,
    this.ProductCategotry,
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
      'ProductCategotry': ProductCategotry,
      'ProductColors': ProductColors,
      'ProductSizes': ProductSizes,
      'ProductPrice': ProductPrice,
      'ProductImageURL': ProductImageURL,
      'ProductQuantity': ProductQuantity,
      // 'isProductBuyed': isProductBuyed,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle ProductID: prefer 'ProductID' field from Firestore, fallback to 'id' (document ID)
    String productId = json['ProductID'] ?? json['id'] ?? '';

    // Handle ProductColors: ensure it's a List<String>
    List<String>? colors;
    if (json['ProductColors'] != null) {
      if (json['ProductColors'] is List) {
        colors =
            (json['ProductColors'] as List).map((e) => e.toString()).toList();
      } else {
        colors = [];
      }
    } else {
      colors = [];
    }

    // Handle ProductSizes: ensure it's a List<String>
    List<String>? sizes;
    if (json['ProductSizes'] != null) {
      if (json['ProductSizes'] is List) {
        sizes =
            (json['ProductSizes'] as List).map((e) => e.toString()).toList();
      } else {
        sizes = [];
      }
    } else {
      sizes = [];
    }

    // Handle ProductImageURL: replace empty strings with placeholder images
    List<String> imageUrls = [];
    if (json['ProductImageURL'] != null && json['ProductImageURL'] is List) {
      List<dynamic> imageList = json['ProductImageURL'] as List;
      imageUrls = imageList.map((e) => e.toString()).toList();

      // Replace empty strings with placeholder images
      for (int i = 0; i < imageUrls.length; i++) {
        if (imageUrls[i].isEmpty || imageUrls[i].trim().isEmpty) {
          imageUrls[i] = placeholderImages[i % placeholderImages.length];
        }
      }
    }

    // If no images provided, add at least one placeholder
    if (imageUrls.isEmpty) {
      imageUrls = [placeholderImages[0]];
    }

    // Handle ProductPrice: ensure it's a number (int or double)
    double price = 0.0;
    if (json['ProductPrice'] != null) {
      if (json['ProductPrice'] is int) {
        price = (json['ProductPrice'] as int).toDouble();
      } else if (json['ProductPrice'] is double) {
        price = json['ProductPrice'] as double;
      } else if (json['ProductPrice'] is String) {
        price = double.tryParse(json['ProductPrice'] as String) ?? 0.0;
      }
    }

    // Handle ProductQuantity: ensure it's an int
    int quantity = 0;
    if (json['ProductQuantity'] != null) {
      if (json['ProductQuantity'] is int) {
        quantity = json['ProductQuantity'] as int;
      } else if (json['ProductQuantity'] is double) {
        quantity = (json['ProductQuantity'] as double).toInt();
      } else if (json['ProductQuantity'] is String) {
        quantity = int.tryParse(json['ProductQuantity'] as String) ?? 0;
      }
    }

    return Product(
      ProductID: productId.isEmpty ? 'No ID' : productId,
      ProductName: json['ProductName']?.toString() ?? 'No Product Name',
      ProductDescription:
          json['ProductDescription']?.toString() ?? 'No Product description',
      ProductCategotry: json['ProductCategotry']?.toString(),
      ProductColors: colors,
      ProductSizes: sizes,
      ProductPrice: price,
      ProductImageURL: imageUrls,
      ProductQuantity: quantity,
      // isProductBuyed: json['isProductBuyed'] ?? false,
    );
  }

  // Get a valid image URL (first non-empty image or placeholder)
  String getDisplayImage() {
    if (ProductImageURL.isNotEmpty) {
      for (var url in ProductImageURL) {
        if (url.isNotEmpty && url.trim().isNotEmpty) {
          return url;
        }
      }
    }
    return placeholderImages[0];
  }

  // Helpful for updating fields without rebuilding everything
  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
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
      ProductCategotry: category ?? this.ProductCategotry,
      ProductColors: colors ?? this.ProductColors,
      ProductSizes: sizes ?? this.ProductSizes,
      ProductQuantity: quantity ?? this.ProductQuantity,
      ProductPrice: price ?? this.ProductPrice,
      ProductImageURL: imageUrl ?? this.ProductImageURL,
    );
  }
}
