import 'package:project_iti_2025/data/models/cart_item.dart';

class CartState {
  final List<CartItem> items;

  const CartState({this.items = const []});

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }


  int get itemCount =>
      items.fold<int>(0, (sum, e) => sum + e.quantity);

  double get subtotal =>
      items.fold<double>(0, (sum, e) => sum + e.price * e.quantity);

  static const double deliveryFee = 2.99;
  static const double taxRate = 0.08;

  double get tax => subtotal * taxRate;

  double get total =>
      subtotal + tax + (items.isEmpty ? 0 : deliveryFee);
}