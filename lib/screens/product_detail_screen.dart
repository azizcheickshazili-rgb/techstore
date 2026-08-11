import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/product_providers.dart';
import '../providers/favorites_provider.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/price_text.dart';
import '../widgets/product_image.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productByIdProvider(id));
    if (product == null) {
      return const Scaffold(body: Center(child: Text('Produit introuvable')));
    }
    final favorite = ref.watch(favoritesProvider).contains(id);
    final info = _ProductInfo(product: product, favorite: favorite, onFavorite: () {
      ref.read(favoritesProvider.notifier).toggle(id);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Détail du produit')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: LayoutBuilder(
              builder: (context, c) {
                if (c.maxWidth > 760) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: ProductImage(url: product.image, height: 520)),
                      const SizedBox(width: 36),
                      Expanded(child: info),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImage(url: product.image, height: 320),
                    const SizedBox(height: 24),
                    info,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final Product product;
  final bool favorite;
  final VoidCallback onFavorite;
  const _ProductInfo({required this.product, required this.favorite, required this.onFavorite});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(product.brand.toUpperCase(), style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w800, letterSpacing: 1.2,
      )),
      const SizedBox(height: 8),
      Text(product.name, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
      const SizedBox(height: 12),
      Row(children: [
        const Icon(Icons.star_rounded, color: Colors.amber),
        const SizedBox(width: 5),
        Text('${product.rating} / 5'),
        const SizedBox(width: 14),
        Text('${product.stock} unités disponibles', style: const TextStyle(color: Colors.grey)),
      ]),
      const SizedBox(height: 20),
      PriceText(price: product.price, oldPrice: product.oldPrice, large: true),
      const SizedBox(height: 18),
      Text(product.description, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.55)),
      const SizedBox(height: 22),
      const Text('Caractéristiques', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
      const SizedBox(height: 8),
      ...product.specs.map<Widget>((s) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [const Icon(Icons.check_circle_outline, size: 18), const SizedBox(width: 9), Text(s)]),
      )),
      const SizedBox(height: 24),
      Row(children: [
        Expanded(child: AddToCartButton(product: product)),
        const SizedBox(width: 10),
        IconButton.filledTonal(onPressed: onFavorite, icon: Icon(favorite ? Icons.favorite : Icons.favorite_border)),
      ]),
    ],
  );
}
