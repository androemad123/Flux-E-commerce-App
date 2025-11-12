import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'delivery_address_model.dart';
import 'order_status.dart';
import 'order_item.dart';

class OrderModel extends Equatable {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final DeliveryAddress deliveryAddress;
  final OrderStatus status;
  final double subtotal;
  final double shippingFee;
  final double total;
  final String paymentMethod;
  final String shippingMethod;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? trackingNumber;
  final double? rating;
  final String? review;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.deliveryAddress,
    required this.status,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.paymentMethod,
    required this.shippingMethod,
    required this.createdAt,
    this.updatedAt,
    this.trackingNumber,
    this.rating,
    this.review,
  });

  factory OrderModel.create({
    required String userId,
    required List<OrderItem> items,
    required DeliveryAddress deliveryAddress,
    required double shippingFee,
    required String paymentMethod,
    required String shippingMethod,
    String? trackingNumber,
    DateTime? createdAt,
  }) {
    final double subtotal =
        items.fold(0, (value, element) => value + element.lineTotal);
    final double total = subtotal + shippingFee;
    final now = createdAt ?? DateTime.now();

    return OrderModel(
      id: '',
      userId: userId,
      items: items,
      deliveryAddress: deliveryAddress,
      status: OrderStatus.pending,
      subtotal: subtotal,
      shippingFee: shippingFee,
      total: total,
      paymentMethod: paymentMethod,
      shippingMethod: shippingMethod,
      createdAt: now,
      trackingNumber: trackingNumber,
      updatedAt: now,
    );
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    DeliveryAddress? deliveryAddress,
    OrderStatus? status,
    double? subtotal,
    double? shippingFee,
    double? total,
    String? paymentMethod,
    String? shippingMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? trackingNumber,
    double? rating,
    String? review,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      shippingFee: shippingFee ?? this.shippingFee,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      rating: rating ?? this.rating,
      review: review ?? this.review,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] ?? json['products'] ?? [];
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (itemsJson as List<dynamic>)
          .map((item) => OrderItem.fromMap(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),
      deliveryAddress: DeliveryAddress.fromMap(
        Map<String, dynamic>.from(json['deliveryAddress'] ?? {}),
      ),
      status: OrderStatusX.fromString(json['status']),
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      shippingFee: (json['shippingFee'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? 'unknown',
      shippingMethod: json['shippingMethod'] ?? 'standard',
      createdAt: (json['createdAt'] is Timestamp)
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
              DateTime.now(),
      updatedAt: json['updatedAt'] == null
          ? null
          : json['updatedAt'] is Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : DateTime.tryParse(json['updatedAt'].toString()),
      trackingNumber: json['trackingNumber'],
      rating: (json['rating'] as num?)?.toDouble(),
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'deliveryAddress': deliveryAddress.toMap(),
      'status': status.name,
      'subtotal': subtotal,
      'shippingFee': shippingFee,
      'total': total,
      'paymentMethod': paymentMethod,
      'shippingMethod': shippingMethod,
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (trackingNumber != null) 'trackingNumber': trackingNumber,
      if (rating != null) 'rating': rating,
      if (review != null) 'review': review,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        items,
        deliveryAddress,
        status,
        subtotal,
        shippingFee,
        total,
        paymentMethod,
        shippingMethod,
        createdAt,
        updatedAt,
        trackingNumber,
        rating,
        review,
      ];
}
