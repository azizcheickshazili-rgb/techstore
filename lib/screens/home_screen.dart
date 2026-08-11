import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_providers.dart';
import '../widgets/product_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final filtered = ref.watch(filteredProductsProvider);
    final categories = ref.watch(categoriesProvider);
    final brands = ref.watch(brandsProvider);
    return products.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.cloud_off_outlined, size: 50),
        const SizedBox(height: 12),
        const Text('Impossible de charger le catalogue', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        const SizedBox(height: 6),
        Text('$error', textAlign: TextAlign.center),
        const SizedBox(height: 16),
        OutlinedButton.icon(onPressed: () => ref.invalidate(productsProvider), icon: const Icon(Icons.refresh), label: const Text('Réessayer')),
      ]))),
      data: (_) => CustomScrollView(slivers: [
        SliverToBoxAdapter(child: _Hero()),
        SliverToBoxAdapter(child: _Toolbar(categories: categories, brands: brands)),
        if (filtered.isEmpty)
          const SliverFillRemaining(hasScrollBody: false, child: Center(child: Text('Aucun produit ne correspond à votre recherche.')))
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(28, 8, 28, 48),
            sliver: SliverLayoutBuilder(builder: (context, constraints) {
              final width = MediaQuery.sizeOf(context).width;
              final count = width >= 1250 ? 4 : width >= 850 ? 3 : width >= 600 ? 2 : 1;
              return SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) => ProductCard(product: filtered[index]), childCount: filtered.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, crossAxisSpacing: 18, mainAxisSpacing: 18, childAspectRatio: width < 600 ? .9 : .68),
              );
            }),
          ),
      ]),
    );
  }
}

class _Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(28, 22, 28, 20),
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(24)),
    child: LayoutBuilder(builder: (context, c) => Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(.1), borderRadius: BorderRadius.circular(8)), child: const Text('TECHNOLOGIE • SÉLECTION PRO', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1))),
        const SizedBox(height: 15),
        const Text('Le matériel qui
fait avancer vos projets.', style: TextStyle(color: Colors.white, fontSize: 34, height: 1.08, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        const Text('Ordinateurs, écrans, composants et périphériques sélectionnés pour travailler, coder et créer.', style: TextStyle(color: Colors.white70, height: 1.5)),
        const SizedBox(height: 20),
        FilledButton(onPressed: () => Scrollable.ensureVisible(context), child: const Text('Découvrir le catalogue')),
      ])),
      if (c.maxWidth > 700) const SizedBox(width: 30),
      if (c.maxWidth > 700) const Icon(Icons.devices_other_rounded, color: Colors.white24, size: 150),
    ]),
  );
}

class _Toolbar extends ConsumerWidget {
  final List<String> categories;
  final List<String> brands;
  const _Toolbar({required this.categories, required this.brands});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
    padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
    child: Column(children: [
      TextField(
        onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
        decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Rechercher un produit, une marque, une catégorie…'),
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
        ...categories.map((c) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(c), selected: ref.watch(selectedCategoryProvider) == c, onSelected: (_) => ref.read(selectedCategoryProvider.notifier).state = c))),
        const SizedBox(width: 10),
        DropdownButton<String>(value: ref.watch(selectedBrandProvider), items: brands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(), onChanged: (v) { if (v != null) ref.read(selectedBrandProvider.notifier).state = v; }),
        const SizedBox(width: 10),
        DropdownButton<SortMode>(value: ref.watch(sortModeProvider), items: const [
          DropdownMenuItem(value: SortMode.featured, child: Text('À la une')),
          DropdownMenuItem(value: SortMode.priceAsc, child: Text('Prix croissant')),
          DropdownMenuItem(value: SortMode.priceDesc, child: Text('Prix décroissant')),
          DropdownMenuItem(value: SortMode.ratingDesc, child: Text('Meilleures notes')),
        ], onChanged: (v) { if (v != null) ref.read(sortModeProvider.notifier).state = v; }),
      ]),
    ]),
  );
}