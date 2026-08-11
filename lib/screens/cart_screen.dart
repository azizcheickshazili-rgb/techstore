import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../widgets/price_text.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartItemsProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final shipping = ref.watch(cartShippingProvider);
    final total = ref.watch(cartTotalProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Panier')),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1050), child: Padding(padding: const EdgeInsets.all(28), child: items.isEmpty
        ? const Center(child: Text('Votre panier est vide.'))
        : Column(children: [
          Expanded(child: ListView.separated(itemCount: items.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (context, index) {
            final item = items[index];
            return Card(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
              SizedBox(width: 90, height: 80, child: Image.network(item.product.image, fit: BoxFit.cover)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 5), PriceText(price: item.product.price)])),
              Row(children: [
                IconButton(onPressed: () => ref.read(cartProvider.notifier).removeOne(item.product.id), icon: const Icon(Icons.remove_circle_outline)),
                Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w800)),
                IconButton(onPressed: () => ref.read(cartProvider.notifier).add(item.product), icon: const Icon(Icons.add_circle_outline)),
              ]),
              IconButton(onPressed: () => ref.read(cartProvider.notifier).remove(item.product.id), icon: const Icon(Icons.delete_outline)),
            ])));
          })),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Sous-total'), Text(formatCfa(subtotal))]),
          const SizedBox(height: 7),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Livraison'), Text(shipping == 0 ? 'Gratuite' : formatCfa(shipping))]),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)), Text(formatCfa(total), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20))]),
          const SizedBox(height: 15),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Commande simulée'), content: Text('Merci ! Votre commande de ${formatCfa(total)} a été enregistrée en mode démonstration.'), actions: [TextButton(onPressed: () { ref.read(cartProvider.notifier).clear(); Navigator.pop(context); }, child: const Text('Terminer'))])), child: const Text('Passer la commande'))),
        ]))),
      ),
    );
  }
}