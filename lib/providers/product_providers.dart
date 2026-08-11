import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/product_repository.dart';
import '../models/product.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) => ProductRepository());

final productsProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).fetchProducts();
});

final categoriesProvider = Provider<List<String>>((ref) {
  final products = ref.watch(productsProvider).valueOrNull ?? const <Product>[];
  return ['Tous', ...{for (final p in products) p.category}];
});

final brandsProvider = Provider<List<String>>((ref) {
  final products = ref.watch(productsProvider).valueOrNull ?? const <Product>[];
  return ['Toutes', ...{for (final p in products) p.brand}];
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedCategoryProvider = StateProvider<String>((ref) => 'Tous');

final selectedBrandProvider = StateProvider<String>((ref) => 'Toutes');

enum SortMode { featured, priceAsc, priceDesc, ratingDesc }

final sortModeProvider = StateProvider<SortMode>((ref) => SortMode.featured);

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider).valueOrNull ?? const <Product>[];
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final category = ref.watch(selectedCategoryProvider);
  final brand = ref.watch(selectedBrandProvider);
  final sort = ref.watch(sortModeProvider);

  final result = products.where((p) {
    final matchesQuery = query.isEmpty ||
        p.name.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query) ||
        p.category.toLowerCase().contains(query) ||
        p.brand.toLowerCase().contains(query);
    final matchesCategory = category == 'Tous' || p.category == category;
    final matchesBrand = brand == 'Toutes' || p.brand == brand;
    return matchesQuery && matchesCategory && matchesBrand;
  }).toList();

  switch (sort) {
    case SortMode.priceAsc:
      result.sort((a, b) => a.price.compareTo(b.price));
    case SortMode.priceDesc:
      result.sort((a, b) => b.price.compareTo(a.price));
    case SortMode.ratingDesc:
      result.sort((a, b) => b.rating.compareTo(a.rating));
    case SortMode.featured:
      break;
  }
  return result;
});

final productByIdProvider = Provider.family<Product?, String>((ref, id) {
  final products = ref.watch(productsProvider).valueOrNull ?? const <Product>[];
  for (final product in products) {
    if (product.id == id) return product;
  }
  return null;
});