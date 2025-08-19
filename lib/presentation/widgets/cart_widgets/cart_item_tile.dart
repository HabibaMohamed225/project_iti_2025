import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_event.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/data/models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  const CartItemTile({super.key, required this.item});

  String _money(double v) => v.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final lineTotal = item.price * item.quantity;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.containerBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                ? Image.network(
                    item.imageUrl!,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 54,
                      height: 54,
                      color: AppColors.lightGrey,
                      child: const Icon(Icons.fastfood, color: AppColors.darkGrey),
                    ),
                  )
                : Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.fastfood, color: AppColors.darkGrey),
                  ),
          ),
          const SizedBox(width: 12),

        
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (item.description != null && item.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 4),
                    child: Text(
                      item.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                Text(
                  '\$${_money(lineTotal)}',
                  style: const TextStyle(
                    color: AppColors.primaryButtonColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

        
          Row(
            children: [
              _QtyBtn(
                icon: Icons.remove,
                onTap: () =>
                    context.read<CartBloc>().add(DecrementItem(item.id)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _QtyBtn(
                icon: Icons.add,
                onTap: () =>
                    context.read<CartBloc>().add(IncrementItem(item.id)),
              ),
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.red),
                onPressed: () =>
                    context.read<CartBloc>().add(RemoveFromCart(item.id)),
                tooltip: 'Remove',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 18, color: AppColors.black),
        ),
      ),
    );
  }
}