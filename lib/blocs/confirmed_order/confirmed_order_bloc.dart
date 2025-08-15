import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/confirmed_order/confirmed_order_event.dart';
import 'package:project_iti_2025/blocs/confirmed_order/confirmed_order_state.dart';

class ConfirmedOrderBloc extends Bloc<ConfirmedOrderEvent, ConfirmedOrderState> {
  ConfirmedOrderBloc() : super(const ConfirmedOrderState(isLoading: true)) {
    on<LoadConfirmedOrder>(_onLoad);
  }

  Future<void> _onLoad(
    LoadConfirmedOrder event,
    Emitter<ConfirmedOrderState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final now = DateTime.now();
      final rnd = Random().nextInt(9000) + 1000;
      final orderId = 'ORD-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-$rnd';

      final email = FirebaseAuth.instance.currentUser?.email;

      emit(
        state.copyWith(
          isLoading: false,
          orderId: orderId,
          orderStatus: 'Confirmed',
          items: event.items,
          itemCount: event.items.fold<int>(0, (acc, e) => acc + e.quantity),
          subtotal: event.subtotal,
          tax: event.tax,
          deliveryFee: event.deliveryFee,
          total: event.total,
          delivery: event.delivery,
          email: email,
          maskedPassword: '********', 
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
