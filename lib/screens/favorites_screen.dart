import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_providers.dart';
import '../providers/favorites_provider.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(favoritesProvider);
    final products = ref.watch(productsProvider);
    return Scaffold(appBar: AppBar(title: const Text('Mes favoris')), body: products.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
      data: (all) {
        final favorites = all.where((p) => ids.contains(p.id)).toList();
        if (favorites.isEmpty) return const Center(child: Text('Aucun favori pour le moment.'));
        return GridView.builder(padding: const EdgeInsets.all(28), itemCount: favorites.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.sizeOf(context).width >= 1000 ? 3 : MediaQuery.sizeOf(context).width >= 650 ? 2 : 1, crossAxisSpacing: 18, mainAxisSpacing: 18, childAspectRatio: .68), itemBuilder: (_, i) => ProductCard(product: favorites[i]));
      },
    ));
  }
}