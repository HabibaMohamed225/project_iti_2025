import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_state.dart';
import 'package:project_iti_2025/blocs/confirmed_order/confirmed_order_bloc.dart';
import 'package:project_iti_2025/blocs/confirmed_order/confirmed_order_event.dart';
import 'package:project_iti_2025/blocs/confirmed_order/confirmed_order_state.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/data/models/delivery/delivery_details.dart';
import 'package:project_iti_2025/presentation/widgets/auth/app_bottom_nav.dart';
import 'package:project_iti_2025/presentation/screens/confirmed_order/confirmed_order_content_screen.dart';

class ConfirmedOrderScreen extends StatefulWidget {
  const ConfirmedOrderScreen({super.key});

  @override
  State<ConfirmedOrderScreen> createState() => _ConfirmedOrderScreenState();
}

class _ConfirmedOrderScreenState extends State<ConfirmedOrderScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final args = ModalRoute.of(context)?.settings.arguments;
    final delivery = args is DeliveryDetails ? args : null;

    final cartState = context.read<CartBloc>().state;

    context.read<ConfirmedOrderBloc>().add(
          LoadConfirmedOrder(
            items: cartState.items,
            subtotal: cartState.subtotal,
            tax: cartState.tax,
            deliveryFee: cartState.items.isEmpty ? 0 : CartState.deliveryFee,
            total: cartState.total,
            delivery: delivery ??
                const DeliveryDetails(
                  fullName: 'No name',
                  phone: '-',
                  street: '-',
                  city: '-',
                ),
          ),
        );

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text('Confirmed Order'),
      ),
      body: BlocBuilder<ConfirmedOrderBloc, ConfirmedOrderState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return ConfirmedOrderContent(state: state);
        },
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
