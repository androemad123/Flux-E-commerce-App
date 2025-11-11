class DeliveryAddress {
  final String street;
  final String city;
  final String zipCode;
  final String country;

  DeliveryAddress({
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
  });

  factory DeliveryAddress.fromMap(Map<String, dynamic> data) {
    return DeliveryAddress(
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      zipCode: data['zipCode'] ?? '',
      country: data['country'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'zipCode': zipCode,
      'country': country,
    };
  }
}
