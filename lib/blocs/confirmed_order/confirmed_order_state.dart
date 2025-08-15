import 'package:equatable/equatable.dart';
import 'package:project_iti_2025/data/models/cart_item.dart';
import 'package:project_iti_2025/data/models/delivery/delivery_details.dart';

class ConfirmedOrderState extends Equatable {
  final bool isLoading;
  final String? error;

  final String? orderId;
  final String? orderStatus;

  final List<CartItem> items;
  final int itemCount;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;

  final DeliveryDetails? delivery;
  final String? email;
  final String maskedPassword;

  const ConfirmedOrderState({
    this.isLoading = false,
    this.error,
    this.orderId,
    this.orderStatus,
    this.items = const [],
    this.itemCount = 0,
    this.subtotal = 0,
    this.tax = 0,
    this.deliveryFee = 0,
    this.total = 0,
    this.delivery,
    this.email,
    this.maskedPassword = '********',
  });

  ConfirmedOrderState copyWith({
    bool? isLoading,
    String? error,
    String? orderId,
    String? orderStatus,
    List<CartItem>? items,
    int? itemCount,
    double? subtotal,
    double? tax,
    double? deliveryFee,
    double? total,
    DeliveryDetails? delivery,
    String? email,
    String? maskedPassword,
  }) {
    return ConfirmedOrderState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      orderId: orderId ?? this.orderId,
      orderStatus: orderStatus ?? this.orderStatus,
      items: items ?? this.items,
      itemCount: itemCount ?? this.itemCount,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      delivery: delivery ?? this.delivery,
      email: email ?? this.email,
      maskedPassword: maskedPassword ?? this.maskedPassword,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        orderId,
        orderStatus,
        items,
        itemCount,
        subtotal,
        tax,
        deliveryFee,
        total,
        delivery,
        email,
        maskedPassword,
      ];
}
