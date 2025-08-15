class DeliveryDetails {
  final String fullName;
  final String phone;
  final String street;
  final String city;
  final String? instructions;

  const DeliveryDetails({
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    this.instructions,
  });
}
