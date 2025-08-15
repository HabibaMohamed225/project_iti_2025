import 'package:equatable/equatable.dart';
import 'package:project_iti_2025/data/models/cart_item.dart';
import 'package:project_iti_2025/data/models/delivery/delivery_details.dart';

abstract class ConfirmedOrderEvent extends Equatable {
  const ConfirmedOrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadConfirmedOrder extends ConfirmedOrderEvent {
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;
  final DeliveryDetails delivery;

  const LoadConfirmedOrder({
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.delivery,
  });

  @override
  List<Object?> get props => [items, subtotal, tax, deliveryFee, total, delivery];
}
