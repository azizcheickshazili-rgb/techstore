import 'package:flutter/material.dart';

String formatCfa(double value) => '${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\\d)(?=(\\d{3})+(?!\\d))'), (m) => '${m[1]} ')} FCFA';

class PriceText extends StatelessWidget {
  final double price;
  final double? oldPrice;
  final bool large;
  const PriceText({super.key, required this.price, this.oldPrice, this.large = false});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(formatCfa(price), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, fontSize: large ? 24 : 16)),
      if (oldPrice != null) ...[
        const SizedBox(width: 8),
        Text(formatCfa(oldPrice!), style: Theme.of(context).textTheme.bodySmall?.copyWith(decoration: TextDecoration.lineThrough, color: Colors.grey)),
      ],
    ],
  );
}