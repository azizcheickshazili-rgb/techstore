import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class AddToCartButton extends ConsumerStatefulWidget {
  final Product product;
  const AddToCartButton({super.key, required this.product});

  @override
  ConsumerState<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends ConsumerState<AddToCartButton> {
  bool _added = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _add() {
    ref.read(cartProvider.notifier).add(widget.product);
    if (!mounted) return;
    _timer?.cancel();
    setState(() => _added = true);
    _timer = Timer(const Duration(milliseconds: 1100), () {
      if (mounted) setState(() => _added = false);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produit ajouté au panier'), duration: Duration(milliseconds: 900)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: widget.product.stock == 0 ? null : _add,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: Icon(_added ? Icons.check_circle : Icons.add_shopping_cart_outlined, key: ValueKey(_added), size: 18),
      ),
      label: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: Text(_added ? 'Ajouté au panier' : 'Ajouter au panier', key: ValueKey(_added)),
      ),
    );
  }
}
