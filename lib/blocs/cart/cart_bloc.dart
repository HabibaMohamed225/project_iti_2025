import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_event.dart';
import 'package:project_iti_2025/blocs/cart/cart_state.dart';
import 'package:project_iti_2025/data/models/cart_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>((event, emit) {
      final updated = List<CartItem>.from(state.items);
      final idx = updated.indexWhere((e) => e.id == event.item.id);
      if (idx >= 0) {
        final ex = updated[idx];
        updated[idx] =
            ex.copyWith(quantity: ex.quantity + event.item.quantity);
      } else {
        updated.add(event.item);
      }
      emit(state.copyWith(items: updated));
    });

    on<RemoveFromCart>((event, emit) {
      final updated =
          state.items.where((item) => item.id != event.id).toList();
      emit(state.copyWith(items: updated));
    });

    on<ClearCart>((event, emit) => emit(const CartState(items: [])));

    on<IncrementItem>((event, emit) {
      final updated = state.items.map((e) {
        if (e.id == event.id) return e.copyWith(quantity: e.quantity + 1);
        return e;
      }).toList();
      emit(state.copyWith(items: updated));
    });

    on<DecrementItem>((event, emit) {
      final updated = <CartItem>[];
      for (final e in state.items) {
        if (e.id == event.id) {
          if (e.quantity > 1) {
            updated.add(e.copyWith(quantity: e.quantity - 1));
          }
        } else {
          updated.add(e);
        }
      }

      emit(state.copyWith(items: updated));
    });
  }
}