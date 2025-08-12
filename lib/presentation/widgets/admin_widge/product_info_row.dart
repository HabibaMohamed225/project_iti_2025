import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';

class ProductInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? textStyle;

  const ProductInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: (textStyle ?? theme.textTheme.bodySmall)?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: (textStyle ?? theme.textTheme.bodySmall)?.copyWith(
                color: AppColors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
