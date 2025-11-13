import 'dart:developer';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

/// Service to seed products from static categoryData to Firestore
class ProductSeedService {
  final ProductBLoC productBLoC;
  bool _isSeeding = false;

  ProductSeedService(this.productBLoC);

  /// Check if products exist in Firestore, if not, seed them
  Future<void> seedIfNeeded() async {
    if (_isSeeding) return;
    
    try {
      // Check if products exist
      productBLoC.add(LoadAllProducts());
      
      // Wait a bit for the state to update
      await Future.delayed(const Duration(seconds: 2));
      
      // Note: In a real app, you'd check the state, but for simplicity,
      // we'll provide a method to manually trigger seeding
      log('Use seedProductsFromCategoryData() to upload products to Firestore');
    } catch (e) {
      log('Error checking products: $e');
    }
  }

  /// Converts categoryData to Product models and uploads to Firestore
  Future<void> seedProductsFromCategoryData() async {
    final Map<String, Map<String, dynamic>> categoryData = {
      "Women": {
        "slider_images": [
          "https://images.pexels.com/photos/974911/pexels-photo-974911.jpeg",
          "https://images.pexels.com/photos/994523/pexels-photo-994523.jpeg",
          "https://images.pexels.com/photos/1375736/pexels-photo-1375736.jpeg",
          "https://images.pexels.com/photos/994523/pexels-photo-994523.jpeg"
        ],
        "header_image":
            "https://images.pexels.com/photos/1375736/pexels-photo-1375736.jpeg",
        "recommended": [
          {
            "name": "Women's Jacket",
            "price": 79.99,
            "image":
                "https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg"
          },
          {
            "name": "Summer Dress",
            "price": 55.00,
            "image":
                "https://images.pexels.com/photos/985635/pexels-photo-985635.jpeg"
          },
          {
            "name": "Casual Shirt",
            "price": 35.99,
            "image":
                "https://images.pexels.com/photos/2065195/pexels-photo-2065195.jpeg"
          },
        ],
        "collection_images": [
          "https://images.pexels.com/photos/1375736/pexels-photo-1375736.jpeg",
          "https://images.pexels.com/photos/974911/pexels-photo-974911.jpeg",
          "https://images.pexels.com/photos/2065200/pexels-photo-2065200.jpeg",
          "https://images.pexels.com/photos/994523/pexels-photo-994523.jpeg"
        ]
      },
      "Men": {
        "slider_images": [
          "https://images.pexels.com/photos/769733/pexels-photo-769733.jpeg",
          "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg",
          "https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg"
        ],
        "header_image":
            "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg",
        "recommended": [
          {
            "name": "Men's Sweater",
            "price": 65.99,
            "image":
                "https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg"
          },
          {
            "name": "Formal Suit",
            "price": 199.99,
            "image":
                "https://images.pexels.com/photos/45055/pexels-photo-45055.jpeg"
          },
          {
            "name": "Casual T-Shirt",
            "price": 25.99,
            "image":
                "https://images.pexels.com/photos/1484807/pexels-photo-1484807.jpeg"
          },
        ],
        "collection_images": [
          "https://images.pexels.com/photos/769733/pexels-photo-769733.jpeg",
          "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg",
          "https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg",
          "https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg"
        ]
      },
      "Accessories": {
        "slider_images": [
          "https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg",
          "https://images.pexels.com/photos/702251/pexels-photo-702251.jpeg",
          "https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg"
        ],
        "header_image":
            "https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg",
        "recommended": [
          {
            "name": "Backpack",
            "price": 85.00,
            "image":
                "https://images.pexels.com/photos/2905238/pexels-photo-2905238.jpeg"
          },
          {
            "name": "Necklace",
            "price": 45.00,
            "image":
                "https://images.pexels.com/photos/965981/pexels-photo-965981.jpeg"
          },
          {
            "name": "Bracelet",
            "price": 35.00,
            "image":
                "https://images.pexels.com/photos/1099816/pexels-photo-1099816.jpeg"
          },
        ],
        "collection_images": [
          "https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg",
          "https://images.pexels.com/photos/702251/pexels-photo-702251.jpeg",
          "https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg",
          "https://images.pexels.com/photos/2905238/pexels-photo-2905238.jpeg"
        ]
      },
      "Beauty": {
        "slider_images": [
          "https://images.pexels.com/photos/2536965/pexels-photo-2536965.jpeg",
          "https://images.pexels.com/photos/1040424/pexels-photo-1040424.jpeg",
          "https://images.pexels.com/photos/3373739/pexels-photo-3373739.jpeg"
        ],
        "header_image":
            "https://images.pexels.com/photos/3373739/pexels-photo-3373739.jpeg",
        "recommended": [
          {
            "name": "Lipstick Set",
            "price": 45.00,
            "image":
                "https://images.pexels.com/photos/2648705/pexels-photo-2648705.jpeg"
          },
          {
            "name": "Face Cream",
            "price": 55.00,
            "image":
                "https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg"
          },
          {
            "name": "Hair Care",
            "price": 35.00,
            "image":
                "https://images.pexels.com/photos/4041391/pexels-photo-4041391.jpeg"
          },
        ],
        "collection_images": [
          "https://images.pexels.com/photos/2536965/pexels-photo-2536965.jpeg",
          "https://images.pexels.com/photos/1040424/pexels-photo-1040424.jpeg",
          "https://images.pexels.com/photos/3373739/pexels-photo-3373739.jpeg",
          "https://images.pexels.com/photos/2648705/pexels-photo-2648705.jpeg"
        ]
      }
    };

    List<Product> productsToUpload = [];

    // Process each category
    categoryData.forEach((category, data) {
      // Process recommended products
      if (data['recommended'] != null) {
        final recommended = data['recommended'] as List<dynamic>;
        for (var item in recommended) {
          final product = _createProductFromData(
            name: item['name'] as String,
            price: (item['price'] as num).toDouble(),
            imageUrl: item['image'] as String,
            category: category,
            description: '${item['name']} - High quality ${category.toLowerCase()} product',
          );
          productsToUpload.add(product);
        }
      }

      // Process slider images as products
      if (data['slider_images'] != null) {
        final sliderImages = data['slider_images'] as List<dynamic>;
        for (int i = 0; i < sliderImages.length; i++) {
          final imageUrl = sliderImages[i] as String;
          final product = _createProductFromData(
            name: '$category Collection Item ${i + 1}',
            price: (50.0 + (i * 10)).toDouble(), // Varying prices
            imageUrl: imageUrl,
            category: category,
            description: 'Premium $category collection item',
          );
          productsToUpload.add(product);
        }
      }

      // Process collection images as products (avoid duplicates)
      if (data['collection_images'] != null) {
        final collectionImages = data['collection_images'] as List<dynamic>;
        final Set<String> seenImages = {};
        
        // First, add all recommended and slider images to seen set
        if (data['recommended'] != null) {
          for (var item in data['recommended'] as List<dynamic>) {
            seenImages.add(item['image'] as String);
          }
        }
        if (data['slider_images'] != null) {
          for (var image in data['slider_images'] as List<dynamic>) {
            seenImages.add(image as String);
          }
        }
        
        // Only add collection images that aren't already added
        for (int i = 0; i < collectionImages.length; i++) {
          final imageUrl = collectionImages[i] as String;
          if (!seenImages.contains(imageUrl)) {
            final product = _createProductFromData(
              name: '$category Style ${i + 1}',
              price: (40.0 + (i * 15)).toDouble(),
              imageUrl: imageUrl,
              category: category,
              description: 'Stylish $category item',
            );
            productsToUpload.add(product);
            seenImages.add(imageUrl);
          }
        }
      }
    });

    // Upload all products to Firestore
    log('Starting to upload ${productsToUpload.length} products to Firestore...');
    int successCount = 0;
    int failureCount = 0;
    
    _isSeeding = true;

    // Upload products one by one with a small delay to avoid overwhelming Firestore
    for (var product in productsToUpload) {
      try {
        productBLoC.add(
          AddProduct(
            ProductID: product.ProductID,
            ProductName: product.ProductName,
            ProductDescription: product.ProductDescription,
            ProductCategotry: product.ProductCategotry,
            ProductPrice: product.ProductPrice,
            ProductImageURL: product.ProductImageURL,
            ProductQuantity: product.ProductQuantity,
            ProductColors: product.ProductColors,
            ProductSizes: product.ProductSizes,
          ),
        );
        successCount++;
        log('Queued product for upload: ${product.ProductName}');
        
        // Small delay between uploads to avoid rate limiting
        await Future.delayed(const Duration(milliseconds: 100));
      } catch (e) {
        failureCount++;
        log('Failed to queue product ${product.ProductName}: $e');
      }
    }

    _isSeeding = false;
    log('Upload complete: $successCount successful, $failureCount failed');
    log('Note: Products are being uploaded asynchronously. Refresh to see them.');
  }

  /// Creates a Product model from data
  Product _createProductFromData({
    required String name,
    required double price,
    required String imageUrl,
    required String category,
    required String description,
  }) {
    return Product(
      ProductID: uuid.v4(),
      ProductName: name,
      ProductDescription: description,
      ProductCategotry: category,
      ProductPrice: price,
      ProductImageURL: [imageUrl],
      ProductQuantity: (20 + (price ~/ 10)).clamp(5, 100), // Quantity based on price
      ProductColors: _getDefaultColorsForCategory(category),
      ProductSizes: _getDefaultSizesForCategory(category),
    );
  }

  /// Returns default colors based on category
  List<String> _getDefaultColorsForCategory(String category) {
    switch (category) {
      case 'Women':
        return ['red', 'pink', 'black', 'white'];
      case 'Men':
        return ['blue', 'gray', 'black', 'navy'];
      case 'Accessories':
        return ['brown', 'black', 'silver', 'gold'];
      case 'Beauty':
        return ['red', 'pink', 'nude', 'coral'];
      default:
        return ['red', 'blue', 'black'];
    }
  }

  /// Returns default sizes based on category
  List<String> _getDefaultSizesForCategory(String category) {
    switch (category) {
      case 'Women':
      case 'Men':
        return ['S', 'M', 'L', 'XL'];
      case 'Accessories':
        return ['One Size'];
      case 'Beauty':
        return ['Small', 'Medium', 'Large'];
      default:
        return ['S', 'M', 'L'];
    }
  }
}
