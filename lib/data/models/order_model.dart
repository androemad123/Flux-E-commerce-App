import 'ordered_product_model.dart';
import 'delivery_address_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<OrderedProduct> products;
  final DeliveryAddress deliveryAddress;
  final String status;
  final double? rating;
  final String? review;

  OrderModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.deliveryAddress,
    required this.status,
    this.rating,
    this.review,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data, String documentId) {
    return OrderModel(
      id: documentId,
      userId: data['userId'] ?? '',
      products: (data['products'] as List<dynamic>)
          .map((item) => OrderedProduct.fromMap(item))
          .toList(),
      deliveryAddress: DeliveryAddress.fromMap(data['deliveryAddress']),
      status: data['status'] ?? 'pending',
      rating: (data['rating'] != null)
          ? (data['rating'] as num).toDouble()
          : null,
      review: data['review'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'products': products.map((p) => p.toMap()).toList(),
      'deliveryAddress': deliveryAddress.toMap(),
      'status': status,
      if (rating != null) 'rating': rating,
      if (review != null) 'review': review,
    };
  }
}
