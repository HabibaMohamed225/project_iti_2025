import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/presentation/widgets/shared_card.dart';
import 'package:project_iti_2025/blocs/confirmed_order/confirmed_order_state.dart';

class ConfirmedOrderContent extends StatelessWidget {
  final ConfirmedOrderState state;

  const ConfirmedOrderContent({
    super.key,
    required this.state,
  });

  String _money(double v) => v.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final delivery = state.delivery;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            children: [
              const Icon(Icons.check_circle, size: 56, color: AppColors.green),
              const SizedBox(height: 8),
              Text(
                'Confirmed Order',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SharedCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.orderSummary,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              ...state.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.name}  x${item.quantity}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.black),
                        ),
                      ),
                      Text('\$${_money(item.price * item.quantity)}'),
                    ],
                  ),
                ),
              ),
              const Divider(height: 24),
              _summaryRow('${AppStrings.subtotal} (${state.itemCount} items)',
                  '\$${_money(state.subtotal)}'),
              const SizedBox(height: 6),
              _summaryRow(
                  AppStrings.deliveryFee, '\$${_money(state.deliveryFee)}'),
              const SizedBox(height: 6),
              _summaryRow(AppStrings.tax, '\$${_money(state.tax)}'),
              const Divider(height: 24),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      AppStrings.total,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '\$${_money(state.total)}',
                    style: const TextStyle(
                      color: AppColors.primaryButtonColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (delivery != null)
          SharedCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppStrings.deliveryAddressTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                _kv('Name', delivery.fullName),
                _kv('Phone', delivery.phone),
                _kv('Street', delivery.street),
                _kv('City', delivery.city),
                if ((delivery.instructions ?? '').isNotEmpty)
                  _kv('Instructions', delivery.instructions!),
              ],
            ),
          ),
        const SizedBox(height: 12),
        SharedCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.yourAccountDetails,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              _kv(AppStrings.email, state.email ?? AppStrings.noEmail),
              _kv(AppStrings.password, state.maskedPassword),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.darkGrey),
          ),
        ),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              k,
              style: const TextStyle(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              v,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
