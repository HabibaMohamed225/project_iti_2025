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
    final theme = Theme.of(context).textTheme;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return Center(
            child: Text(
              AppStrings.backToCart,
              style: theme.bodyMedium?.copyWith(
                color: AppColors.darkGrey,
                fontSize: 16,
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...state.items.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CartItemTile(item: e),
                )),
            const SizedBox(height: 16),
            SharedCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.orderSummary,
                    style: theme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _row(theme, "${AppStrings.subtotal} (${state.itemCount} items)", "\$${_money(state.subtotal)}"),
                  _row(theme, AppStrings.deliveryFee, state.items.isEmpty ? "\$0.00" : "\$${_money(CartState.deliveryFee)}"),
                  _row(theme, AppStrings.tax, "\$${_money(state.tax)}"),
                  const Divider(height: 24),
                  _row(theme, AppStrings.total, "\$${_money(state.total)}", isTotal: true),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: AppStrings.proceedToCheckout,
                    onPressed: () => Navigator.of(context).pushNamed('/delivery'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _row(TextTheme theme, String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.bodyMedium?.copyWith(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? AppColors.black : AppColors.darkGrey,
              ),
            ),
          ),
          Text(
            value,
            style: theme.bodyMedium?.copyWith(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
              color: isTotal ? AppColors.primaryButtonColor : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
