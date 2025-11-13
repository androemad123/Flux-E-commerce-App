import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String country;
  final String city;
  final String state;
  final String street;
  final String zipCode;
  final String? apartment;

  const DeliveryAddress({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.country,
    required this.city,
    required this.state,
    required this.street,
    required this.zipCode,
    this.apartment,
  });

  DeliveryAddress copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? country,
    String? city,
    String? state,
    String? street,
    String? zipCode,
    String? apartment,
  }) {
    return DeliveryAddress(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      apartment: apartment ?? this.apartment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'country': country,
      'city': city,
      'state': state,
      'street': street,
      'zipCode': zipCode,
      if (apartment != null && apartment!.isNotEmpty) 'apartment': apartment,
    };
  }

  factory DeliveryAddress.fromMap(Map<String, dynamic> data) {
    return DeliveryAddress(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      country: data['country'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      street: data['street'] ?? '',
      zipCode: data['zipCode'] ?? '',
      apartment: data['apartment'],
    );
  }

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        country,
        city,
        state,
        street,
        zipCode,
        apartment,
      ];
}
