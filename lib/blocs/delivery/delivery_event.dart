import 'package:equatable/equatable.dart';

abstract class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object?> get props => [];
}

class SubmitDeliveryEvent extends DeliveryEvent {
  final String fullName;
  final String phone;
  final String street;
  final String city;
  final String instructions;

  const SubmitDeliveryEvent({
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    required this.instructions,
  });

  @override
  List<Object?> get props => [fullName, phone, street, city, instructions];
}
