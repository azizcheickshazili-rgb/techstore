import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String url;
  final double? height;
  final BorderRadius borderRadius;
  const ProductImage({super.key, required this.url, this.height, this.borderRadius = const BorderRadius.all(Radius.circular(16))});

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: borderRadius,
    child: Container(
      height: height,
      width: double.infinity,
      color: Colors.white,
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.image_not_supported_outlined, size: 42)),
        loadingBuilder: (context, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
    ),
  );
}