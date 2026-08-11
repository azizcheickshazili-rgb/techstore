import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/product_repository.dart';
import '../models/product.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(),
);

final productsProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).fetchProducts();
});

final categoriesProvider = Provider<List<String>>((ref) {
  final products = ref.watch(productsProvider).value ?? const <Product>[];
  final values = <String>{for (final product in products) product.category};
  return ['Tous', ...values.toList()..sort()];
});

final brandsProvider = Provider<List<String>>((ref) {
  final products = ref.watch(productsProvider).value ?? const <Product>[];
  final values = <String>{for (final product in products) product.brand};
  return ['Toutes', ...values.toList()..sort()];
});

class StringValueNotifier extends Notifier<String> {
  final String initialValue;

  StringValueNotifier(this.initialValue);

  @override
  String build() => initialValue;

  void setValue(String value) => state = value;
}

final searchQueryProvider = NotifierProvider<StringValueNotifier, String>(
  () => StringValueNotifier(''),
);

final selectedCategoryProvider = NotifierProvider<StringValueNotifier, String>(
  () => StringValueNotifier('Tous'),
);

final selectedBrandProvider = NotifierProvider<StringValueNotifier, String>(
  () => StringValueNotifier('Toutes'),
);

enum SortMode { featured, priceAsc, priceDesc, ratingDesc }

class SortModeNotifier extends Notifier<SortMode> {
  @override
  SortMode build() => SortMode.featured;

  void setMode(SortMode value) => state = value;
}

final sortModeProvider = NotifierProvider<SortModeNotifier, SortMode>(
  SortModeNotifier.new,
);

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider).value ?? const <Product>[];
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final category = ref.watch(selectedCategoryProvider);
  final brand = ref.watch(selectedBrandProvider);
  final sort = ref.watch(sortModeProvider);

  final result = products.where((product) {
    final searchable = '${product.name} ${product.description} '
        '${product.category} ${product.brand}'.toLowerCase();
    final matchesQuery = query.isEmpty || searchable.contains(query);
    final matchesCategory = category == 'Tous' || product.category == category;
    final matchesBrand = brand == 'Toutes' || product.brand == brand;
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
  final products = ref.watch(productsProvider).value ?? const <Product>[];
  for (final product in products) {
    if (product.id == id) return product;
  }
  return null;
});
