import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_event.dart';
import 'package:project_iti_2025/data/models/cart_item.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.containerBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.containerBorder),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        leading: item.imageUrl != null && item.imageUrl!.isNotEmpty
            ? CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(item.imageUrl!),
              )
            : const CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.lightGrey,
                child: Icon(Icons.fastfood, color: AppColors.darkGrey),
              ),
        title: Text(
          item.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTextColor,
          ),
        ),
        subtitle: Text(
          "\$${(item.price * item.quantity).toStringAsFixed(2)}",
          style: const TextStyle(
            color: AppColors.primaryButtonColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: AppColors.black),
              onPressed: () =>
                  context.read<CartBloc>().add(DecrementItem(item.id)),
            ),
            Text(
              "${item.quantity}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: AppColors.black),
              onPressed: () =>
                  context.read<CartBloc>().add(IncrementItem(item.id)),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.red),
              onPressed: () =>
                  context.read<CartBloc>().add(RemoveFromCart(item.id)),
            ),
          ],
        ),
      ),
    );
  }
}
