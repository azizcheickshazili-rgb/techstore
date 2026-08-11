import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';

class AppShell extends ConsumerWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartCountProvider);
    final favCount = ref.watch(favoriteCountProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 28,
        title: InkWell(onTap: () => Navigator.pushReplacementNamed(context, '/'), child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.memory_rounded, size: 27),
          SizedBox(width: 8),
          Text('TECHSTORE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.4)),
        ])),
        actions: [
          TextButton.icon(onPressed: () => Navigator.pushNamed(context, '/favorites'), icon: const Icon(Icons.favorite_border), label: Text('Favoris${favCount > 0 ? ' ($favCount)' : ''}')),
          const SizedBox(width: 4),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/profile'), icon: const Icon(Icons.person_outline), tooltip: 'Profil'),
          Stack(alignment: Alignment.topRight, children: [
            IconButton(onPressed: () => Navigator.pushNamed(context, '/cart'), icon: const Icon(Icons.shopping_bag_outlined), tooltip: 'Panier'),
            if (cartCount > 0) Container(margin: const EdgeInsets.only(top: 6, right: 4), padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10)), child: Text('$cartCount', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
          ]),
          const SizedBox(width: 18),
        ],
      ),
      body: child,
    );
  }
}