import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_state.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/presentation/widgets/cart_widgets/cart_item_tile.dart';
import 'package:project_iti_2025/presentation/widgets/primary_botton.dart';
import 'package:project_iti_2025/presentation/widgets/shared_card.dart';

class CartScreenContent extends StatelessWidget {
  const CartScreenContent({super.key});

  String _money(double v) => v.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 12),
            ...state.items.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CartItemTile(item: e),
                )),
            const SizedBox(height: 12),
            SharedCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    AppStrings.orderSummary,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SummaryRow(
                    label: '${AppStrings.subtotal} (${state.itemCount} items)',
                    value: '\$${_money(state.subtotal)}',
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: AppStrings.deliveryFee,
                    value: state.items.isEmpty
                        ? '\$0.00'
                        : '\$${_money(CartState.deliveryFee)}',
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: AppStrings.tax,
                    value: '\$${_money(state.tax)}',
                  ),
                  const Divider(height: 24),
                  _SummaryRowTotal(
                    label: AppStrings.total,
                    value: '\$${_money(state.total)}',
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: AppStrings.proceedToCheckout,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/delivery');
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.darkGrey, fontSize: 14),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SummaryRowTotal extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRowTotal({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryButtonColor,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
