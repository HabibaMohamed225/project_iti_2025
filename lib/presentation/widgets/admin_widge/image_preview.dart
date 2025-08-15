import 'package:flutter/material.dart';

class ProductImagePreview extends StatelessWidget {
  final String imageUrl;
  const ProductImagePreview({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return const SizedBox();
    return Image.network(
      imageUrl,
      height: 150,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
