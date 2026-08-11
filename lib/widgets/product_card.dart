import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/favorites_provider.dart';
import 'price_text.dart';
import 'product_image.dart';
import 'add_to_cart_button.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorite = ref.watch(favoritesProvider).contains(product.id);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/product/${product.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductImage(url: product.image, height: 210),
                if (product.badge != null)
                  Positioned(left: 12, top: 12, child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(8)),
                    child: Text(product.badge!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
                  )),
                Positioned(right: 10, top: 10, child: Material(
                  color: Colors.white.withValues(alpha: 0.94),
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: 'Favori',
                    onPressed: () => ref.read(favoritesProvider.notifier).toggle(product.id),
                    icon: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: favorite ? Colors.red : Colors.black87),
                  ),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(product.brand.toUpperCase(), style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1.1, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 5),
                Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 8),
                Row(children: [const Icon(Icons.star_rounded, size: 17, color: Colors.amber), const SizedBox(width: 4), Text(product.rating.toString()), const Spacer(), Text('${product.stock} en stock', style: const TextStyle(fontSize: 12, color: Colors.grey))]),
                const SizedBox(height: 10),
                PriceText(price: product.price, oldPrice: product.oldPrice),
                const SizedBox(height: 12),
                SizedBox(width: double.infinity, child: AddToCartButton(product: product)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}