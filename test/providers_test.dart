import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techstore/providers/cart_provider.dart';
import 'package:techstore/providers/product_providers.dart';
import 'package:techstore/models/product.dart';

void main() {
  const product = Product(
    id: 'test', name: 'Test SSD', category: 'Stockage', price: 50000,
    rating: 5, stock: 2, brand: 'Test', description: 'Produit test',
    specs: ['1 To'], image: 'https://example.com/image.jpg',
  );

  test('cart adds and removes quantities', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(cartProvider.notifier).add(product);
    container.read(cartProvider.notifier).add(product);
    expect(container.read(cartCountProvider), 2);
    container.read(cartProvider.notifier).removeOne(product.id);
    expect(container.read(cartCountProvider), 1);
    container.read(cartProvider.notifier).remove(product.id);
    expect(container.read(cartCountProvider), 0);
  });

  test('filter provider can be overridden with products', () {
    final container = ProviderContainer(overrides: [
      productsProvider.overrideWith((ref) async => [product]),
    ]);
    addTearDown(container.dispose);
    expect(container.read(productsProvider).value?.first.name, 'Test SSD');
  });
}