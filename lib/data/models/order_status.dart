enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

extension OrderStatusX on OrderStatus {
  String get value => name;

  bool get isTerminal =>
      this == OrderStatus.delivered || this == OrderStatus.cancelled;

  static OrderStatus fromString(String? status) {
    if (status == null || status.isEmpty) {
      return OrderStatus.pending;
    }
    return OrderStatus.values.firstWhere(
      (s) => s.name.toLowerCase() == status.toLowerCase(),
      orElse: () => OrderStatus.pending,
    );
  }
}
