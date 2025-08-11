import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_iti_2025/blocs/admin/admin_bloc.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/data/models/product_model.dart';
import 'package:project_iti_2025/presentation/widgets/primary_botton.dart';

class ProductFormActions extends StatelessWidget {
  final bool isUploading;
  final GlobalKey<FormState> formKey;
  final Product? product;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController imageUrlController;

  const ProductFormActions({
    super.key,
    required this.isUploading,
    required this.formKey,
    required this.product,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.imageUrlController,
  });

  Future<XFile?> _pickImage() async {
    final picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  void _submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (imageUrlController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppStrings.imageUrl,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.white),
            ),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }
      final productData = Product(
        id: product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        imageUrl: imageUrlController.text,
      );
      if (product == null) {
        context.read<ProductBloc>().add(AddProductEvent(productData));
      } else {
        context.read<ProductBloc>().add(UpdateProductEvent(productData));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            text: isUploading ? "Uploading..." : "Upload Image",
            onPressed: isUploading
                ? () {}
                : () async {
                    final pickedFile = await _pickImage();
                    if (pickedFile != null) {
                      if (context.mounted) {
                        context
                            .read<ProductBloc>()
                            .add(UploadImageEvent(pickedFile));
                      }
                    }
                  },
            isLoading: isUploading,
            icon: const Icon(Icons.image,
                size: 20, color: AppColors.containerBorder),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: PrimaryButton(
            text: AppStrings.saveChanges,
            onPressed: () => _submitForm(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(AppStrings.cancel),
          ),
        ),
      ],
    );
  }
}
