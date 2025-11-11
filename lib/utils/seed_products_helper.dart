import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/services/product_seed_service.dart';

/// Helper function to seed products to Firestore
/// 
/// Usage:
/// 1. Call this function once to upload all products from categoryData to Firestore
/// 2. After calling, products will be available in Firestore and displayed in the app
/// 
/// Example:
/// ```dart
/// final productBLoC = context.read<ProductBLoC>();
/// await seedProductsToFirestore(productBLoC);
/// ```
Future<void> seedProductsToFirestore(ProductBLoC productBLoC) async {
  final seedService = ProductSeedService(productBLoC);
  await seedService.seedProductsFromCategoryData();
}

