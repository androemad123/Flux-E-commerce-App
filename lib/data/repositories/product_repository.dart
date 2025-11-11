import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ProductModel.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final querySnapshot = await _firestore
        .collection('products')
        .where('Category', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => Product.fromJson(doc.data()))
        .toList();
  }
}
