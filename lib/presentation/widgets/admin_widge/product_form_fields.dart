import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';

class ProductFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController imageUrlController;

  const ProductFormFields({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.imageUrlController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(labelText: AppStrings.itemName),
          validator: (value) =>
              value == null || value.isEmpty ? "Required" : null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: AppStrings.price),
          validator: (value) =>
              value == null || value.isEmpty ? "Required" : null,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(labelText: AppStrings.description),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: imageUrlController,
          decoration: const InputDecoration(labelText: AppStrings.imageUrl),
        ),
      ],
    );
  }
}
