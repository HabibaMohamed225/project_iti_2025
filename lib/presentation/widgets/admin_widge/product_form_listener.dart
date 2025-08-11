import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/admin/admin_bloc.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';

class ProductFormListener extends StatelessWidget {
  final TextEditingController imageUrlController;
  const ProductFormListener({super.key, required this.imageUrlController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductImageUploadedState) {
          imageUrlController.text = state.imageUrl;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "✅ ${AppStrings.image} uploaded successfully",
                style: theme.appBarTheme.toolbarTextStyle,
              ),
            ),
          );
        } else if (state is ProductImageUploadErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${AppStrings.errorOccurred} ${state.error}",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          );
        } else if (state is ProductSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: theme.textTheme.bodyMedium),
            ),
          );
          Navigator.pop(context, true);
        } else if (state is ProductErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: theme.textTheme.bodyMedium),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
