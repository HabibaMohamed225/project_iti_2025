// lib/data/models/cart_item.dart
class CartItem {
  final String id;         
  final String name;         
  final double price;        
  final int quantity;        
  final String? imageUrl;    
  final String? description; 

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.imageUrl,
    this.description,
  });

  CartItem copyWith({
    int? quantity,
    String? imageUrl,
    String? description,
  }) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }
}