import 'package:equatable/equatable.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object?> get props => [];
}

class DeliveryInitial extends DeliveryState {}

class DeliverySubmitting extends DeliveryState {}

class DeliverySuccess extends DeliveryState {
  final String message;
  const DeliverySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeliveryFailure extends DeliveryState {
  final String error;
  const DeliveryFailure(this.error);

  @override
  List<Object?> get props => [error];
}
