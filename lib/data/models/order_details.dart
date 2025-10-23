import 'package:depi_graduation/data/models/ProductModel.dart';

import 'order_status.dart';

class OrderDetails {
  final String id;
  final String trackingNumber;
  final DateTime date;
  final OrderStatus status;
  final int quantity;
  final double total;
  final String address;
  final List<Product> products;

  OrderDetails({
    required this.id,
    required this.trackingNumber,
    required this.date,
    required this.status,
    required this.quantity,
    required this.total,
    required this.address,
    required this.products,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      trackingNumber: json['trackingNumber'],
      date: DateTime.parse(json['date']),
      status: OrderStatus.values.firstWhere(
        (s) => s.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      quantity: json['quantity'],
      total: (json['total'] as num).toDouble(),
      address: json['address'],
      products:
          (json['products'] as List).map((p) => Product.fromJson(p)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trackingNumber': trackingNumber,
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
      'quantity': quantity,
      'total': total,
      'address': address,
      'products': products.map((p) => p.tojson()).toList(),
    };
  }
  //testing orders only
  static final List<OrderDetails> mockOrders = [
    OrderDetails(
      id: "ORD001",
      trackingNumber: "TRK123456",
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: OrderStatus.delivered,
      quantity: 2,
      total: 59.98,
      address: "123 Main Street, Cairo, Egypt",
      products: [
        Product(
          ProductID: "P001",
          ProductName: "Wireless Mouse",
          ProductDescription: "Ergonomic wireless mouse with USB receiver",
          ProductQuantity: 1,
          ProductPrice: 19.99,
          ProductImageURL: "https://example.com/mouse.jpg",
        ),
        Product(
          id: "P002",
          name: "Mechanical Keyboard",
          description: "RGB backlit mechanical keyboard",
          quantity: 1,
          price: 39.99,
          imageUrl: "https://example.com/keyboard.jpg",
        ),
      ],
    ),
    OrderDetails(
      id: "ORD002",
      trackingNumber: "TRK654321",
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: OrderStatus.pending,
      quantity: 3,
      total: 149.97,
      address: "456 Nile Avenue, Giza, Egypt",
      products: [
        Product(
          id: "P003",
          name: "Smartphone",
          description: "Latest Android smartphone with 128GB storage",
          quantity: 1,
          price: 99.99,
          imageUrl: "https://example.com/phone.jpg",
        ),
        Product(
          id: "P004",
          name: "Phone Case",
          description: "Shockproof protective phone case",
          quantity: 2,
          price: 24.99,
          imageUrl: "https://example.com/case.jpg",
        ),
      ],
    ),
    OrderDetails(
      id: "ORD003",
      trackingNumber: "TRK789012",
      date: DateTime.now().subtract(const Duration(days: 10)),
      status: OrderStatus.canceled,
      quantity: 1,
      total: 49.99,
      address: "789 Pyramid Road, Luxor, Egypt",
      products: [
        Product(
          id: "P005",
          name: "Bluetooth Speaker",
          description: "Portable Bluetooth speaker with deep bass",
          quantity: 1,
          price: 49.99,
          imageUrl: "https://example.com/speaker.jpg",
        ),
      ],
    ),
  ];
}
