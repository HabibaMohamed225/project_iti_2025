import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';

class SharedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SharedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.containerBorder),
      ),
      child: child,
    );
  }
}
