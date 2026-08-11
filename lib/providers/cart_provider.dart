import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) => CartItem(product: product, quantity: quantity ?? this.quantity);
}

class CartNotifier extends Notifier<Map<String, CartItem>> {
  @override
  Map<String, CartItem> build() => {};

  void add(Product product) {
    final current = state[product.id];
    final quantity = (current?.quantity ?? 0) + 1;
    if (quantity > product.stock) return;
    state = {...state, product.id: CartItem(product: product, quantity: quantity)};
  }

  void removeOne(String id) {
    final current = state[id];
    if (current == null) return;
    if (current.quantity <= 1) {
      final next = {...state}..remove(id);
      state = next;
    } else {
      state = {...state, id: current.copyWith(quantity: current.quantity - 1)};
    }
  }

  void remove(String id) {
    final next = {...state}..remove(id);
    state = next;
  }

  void clear() => state = {};
}

final cartProvider = NotifierProvider<CartNotifier, Map<String, CartItem>>(CartNotifier.new);

final cartItemsProvider = Provider<List<CartItem>>((ref) => ref.watch(cartProvider).values.toList());

final cartCountProvider = Provider<int>((ref) =>
    ref.watch(cartProvider).values.fold(0, (sum, item) => sum + item.quantity));

final cartSubtotalProvider = Provider<double>((ref) =>
    ref.watch(cartProvider).values.fold(0, (sum, item) => sum + item.product.price * item.quantity));

final cartShippingProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  return subtotal == 0 || subtotal >= 250000 ? 0 : 5000;
});

final cartTotalProvider = Provider<double>((ref) =>
    ref.watch(cartSubtotalProvider) + ref.watch(cartShippingProvider));