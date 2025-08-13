import 'package:project_iti_2025/data/models/cart_item.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;
  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final String id;
  RemoveFromCart(this.id);
}

class ClearCart extends CartEvent {}

class IncrementItem extends CartEvent {
  final String id;
  IncrementItem(this.id);
}

class DecrementItem extends CartEvent {
  final String id;
  DecrementItem(this.id);
}