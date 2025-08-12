import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/admin/admin_bloc.dart';
import 'package:project_iti_2025/data/models/product_model.dart';
import 'package:project_iti_2025/presentation/widgets/admin_widge/image_preview.dart';
import 'package:project_iti_2025/presentation/widgets/admin_widge/product_form_actions.dart';
import 'package:project_iti_2025/presentation/widgets/admin_widge/product_form_fields.dart';
import 'package:project_iti_2025/presentation/widgets/admin_widge/product_form_listener.dart';

class ProductFormPageContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Product? product;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController imageUrlController;

  const ProductFormPageContent({
    super.key,
    required this.formKey,
    this.product,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.imageUrlController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final isUploading = state is ProductUploadingImageState;

          return Form(
            key: formKey,
            child: ListView(
              children: [
                ProductFormFields(
                  nameController: nameController,
                  priceController: priceController,
                  descriptionController: descriptionController,
                  imageUrlController: imageUrlController,
                  // لو حابة تمرري style للنصوص داخل الفورم:
                  // textStyle: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                ProductFormActions(
                  isUploading: isUploading,
                  formKey: formKey,
                  product: product,
                  nameController: nameController,
                  priceController: priceController,
                  descriptionController: descriptionController,
                  imageUrlController: imageUrlController,
                ),
                const SizedBox(height: 20),
                Container(
                  color: theme.colorScheme.surfaceBright,
                  child: ProductImagePreview(imageUrl: imageUrlController.text),
                ),
                ProductFormListener(imageUrlController: imageUrlController),
              ],
            ),
          );
        },
      ),
    );
  }
}
