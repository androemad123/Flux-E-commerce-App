import 'dart:developer';

import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/firebase_services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class ProductBLoC extends Bloc<ProductEvent, ProductState> {
  final firestore = FirestoreService<Product>(
      collection: "products",
      fromJson: (json) => Product.fromJson(json),
      toJson: (product) => product.tojson());

  // Cache for all products and categories
  List<Product>? _cachedAllProducts;
  final Map<String, List<Product>> _categoryCache = {};
  final Map<String, Product> _productCache = {};

  ProductBLoC() : super(initialState(products: [])) {
    on<LoadAllProducts>(
          (event, emit) async {
        // Return cached data immediately if available
        if (_cachedAllProducts != null && _cachedAllProducts!.isNotEmpty) {
          emit(AllProductsLoaded(products: _cachedAllProducts!));
          return;
        }

        emit(ProductLoading());
        try {
          List<Product?> products = await firestore.getAll();
          // Filter out null products and cast to Product
          List<Product> validProducts = products.where((p) => p != null).cast<Product>().toList();

          // Apply duplication logic only if needed for UI
          final processedProducts = _applyDuplicationLogic(validProducts);

          // Cache the results
          _cachedAllProducts = processedProducts;

          if (processedProducts.isEmpty) {
            emit(AllProductsLoaded(products: []));
          } else {
            emit(AllProductsLoaded(products: processedProducts));
          }
        } catch (e) {
          emit(ErrorState(errorMSG: "Error loading products: $e"));
        }
      },
    );

    on<LoadProduct>(
          (event, emit) async {
        // Check cache first
        if (_productCache.containsKey(event.ProductID)) {
          emit(ProductLoaded(product: _productCache[event.ProductID]!));
          return;
        }

        emit(ProductLoading());
        try {
          Product? product = await firestore.get(event.ProductID);
          if (product == null) {
            emit(ErrorState(errorMSG: "Product Not Found"));
          } else {
            // Cache the product
            _productCache[event.ProductID] = product;
            emit(ProductLoaded(product: product));
          }
        } catch (e) {
          emit(ErrorState(errorMSG: "Error loading product: $e"));
        }
      },
    );

    on<LoadSpecificProduct>(
          (event, emit) async {
        // Create a cache key for this specific query
        final cacheKey = '${event.field}_${event.isEqualTo}';

        // Check cache first
        if (_categoryCache.containsKey(cacheKey)) {
          emit(SpecificProducts(products: _categoryCache[cacheKey]!));
          return;
        }

        emit(ProductLoading());
        try {
          List<Product?> products = await firestore.getWhere(event.field, event.isEqualTo);
          // Filter out null products and cast to Product
          List<Product> validProducts = products.where((p) => p != null).cast<Product>().toList();

          // Apply duplication logic
          final processedProducts = _applyDuplicationLogic(validProducts);

          // Cache the results
          _categoryCache[cacheKey] = processedProducts;

          if (processedProducts.isEmpty) {
            emit(SpecificProducts(products: []));
          } else {
            emit(SpecificProducts(products: processedProducts));
          }
        } catch (e) {
          emit(ErrorState(errorMSG: "Error loading products: $e"));
        }
      },
    );

    on<LoadCategoryProduct>(
          (event, emit) async {
        // Check cache first - this is the key fix for category switching
        if (_categoryCache.containsKey(event.ProductCategotry)) {
          emit(SpecificProducts(products: _categoryCache[event.ProductCategotry]!));
          return;
        }

        // Also check if we have all products cached and can filter from there
        if (_cachedAllProducts != null) {
          final categoryProducts = _cachedAllProducts!
              .where((p) => p.ProductCategotry == event.ProductCategotry)
              .toList();

          if (categoryProducts.isNotEmpty) {
            // Cache the filtered results
            _categoryCache[event.ProductCategotry] = categoryProducts;
            emit(SpecificProducts(products: categoryProducts));
            return;
          }
        }

        emit(ProductLoading());
        try {
          List<Product?> products = [];
          try {
            products = await firestore.getWhere('ProductCategotry', event.ProductCategotry);
          } catch (e) {
            // If category field doesn't exist, fallback to loading all products
            if (_cachedAllProducts != null) {
              products = _cachedAllProducts!;
            } else {
              products = await firestore.getAll();
              _cachedAllProducts = products.where((p) => p != null).cast<Product>().toList();
            }
          }

          // Filter out null products and cast to Product
          List<Product> validProducts = products.where((p) => p != null).cast<Product>().toList();

          // Filter by category if we loaded all products
          if (validProducts.isNotEmpty && validProducts.any((p) => p.ProductCategotry != event.ProductCategotry)) {
            validProducts = validProducts.where((p) => p.ProductCategotry == event.ProductCategotry).toList();
          }

          // Apply duplication logic
          final processedProducts = _applyDuplicationLogic(validProducts);

          // Cache the results
          _categoryCache[event.ProductCategotry] = processedProducts;

          if (processedProducts.isEmpty) {
            emit(SpecificProducts(products: []));
          } else {
            emit(SpecificProducts(products: processedProducts));
          }
        } catch (e) {
          emit(ErrorState(errorMSG: "Error loading category products: $e"));
        }
      },
    );

    on<AddProduct>(
          (event, emit) async {
        try {
          // Generate ProductID if not provided
          String productId = event.ProductID ?? uuid.v4();

          // Create product with all fields
          Product newProduct = Product(
            ProductID: productId,
            ProductName: event.ProductName,
            ProductDescription: event.ProductDescription,
            ProductCategotry: event.ProductCategotry,
            ProductPrice: event.ProductPrice,
            ProductImageURL: event.ProductImageURL,
            ProductQuantity: event.ProductQuantity,
            ProductColors: event.ProductColors ?? ['red', 'blue', 'black'],
            ProductSizes: event.ProductSizes ?? ['S', 'M', 'L'],
          );

          // Upload to Firestore
          String docId = await firestore.create(newProduct);
          log('Product created with ID: $docId');

          // Clear caches to force refresh
          _clearCaches();

          // Reload all products to reflect the new addition
          add(LoadAllProducts());
        } catch (e) {
          emit(ErrorState(errorMSG: "Error adding product: $e"));
        }
      },
    );

    on<AdminEditProduct>(
          (event, emit) async {
        // When editing products, clear relevant caches
        _clearCaches();
      },
    );

    on<DeleteProduct>(
          (event, emit) {
        // When deleting products, clear relevant caches
        _clearCaches();
      },
    );

    // Add a new event to manually refresh data
    on<RefreshProducts>(
          (event, emit) async {
        _clearCaches();
        add(LoadAllProducts());
      },
    );
  }

  // Helper method to apply duplication logic for single products
  List<Product> _applyDuplicationLogic(List<Product> products) {
    if (products.length == 1) {
      final singleProduct = products[0];
      // Return the same instance multiple times (not copies)
      // This ensures image caching works properly since it's the same object
      return [singleProduct, singleProduct, singleProduct];
    }
    return products;
  }

  // Helper method to clear all caches
  void _clearCaches() {
    _cachedAllProducts = null;
    _categoryCache.clear();
    _productCache.clear();
  }

  // Public method to manually clear cache if needed
  void clearCache() {
    _clearCaches();
  }

  // Public method to get current cached state
  List<Product>? getCachedProducts() {
    return _cachedAllProducts;
  }

  // Public method to get cached category products
  List<Product>? getCachedCategoryProducts(String category) {
    return _categoryCache[category];
  }
}

// Add a new event for manual refresh
class RefreshProducts extends ProductEvent {
  @override
  List<Object?> get props => [];
}