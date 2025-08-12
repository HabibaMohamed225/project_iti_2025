import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/data/models/product_model.dart';
import 'package:project_iti_2025/presentation/widgets/admin_widge/product_info_row.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.containerBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              color: AppColors.lightGrey,
              image: product.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: product.imageUrl.isEmpty
                ? const Icon(
                    Icons.image,
                    size: 40,
                    color: AppColors.darkGrey,
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ProductInfoRow(
                  label: AppStrings.itemName,
                  value: product.name.isNotEmpty ? product.name : '-',
                  textStyle: theme.textTheme.bodySmall,
                ),
                ProductInfoRow(
                  label: AppStrings.price,
                  value: '\$${product.price}',
                  textStyle: theme.textTheme.bodySmall,
                ),
                ProductInfoRow(
                  label: AppStrings.description,
                  value: product.description.isNotEmpty
                      ? product.description
                      : '-',
                  textStyle: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.mode_edit_outline,
                    color: AppColors.black,
                  ),
                  onPressed: onEdit,
                  tooltip: AppStrings.edit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.red),
                  onPressed: onDelete,
                  tooltip: AppStrings.cancel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
