# TECHSTORE — Flutter Web E-commerce

TechStore est une boutique web de matériel informatique réalisée avec **Flutter + Riverpod**. Le projet a été pensé pour répondre au cahier des charges du projet « App e-commerce avec Riverpod » tout en proposant une interface de boutique crédible et non générique.

## Fonctionnalités couvertes

- Catalogue produits : liste + détail.
- Panier : ajout, suppression, augmentation/diminution des quantités.
- Favoris persistants localement avec `shared_preferences`.
- Recherche plein texte.
- Filtrage par catégorie et marque.
- Tri par prix et note.
- Profil utilisateur mock.
- États `loading`, `error` et `data` visibles dans l'UI.
- Données asynchrones via `FutureProvider` depuis `assets/data/products.json`.
- Plus de 5 providers Riverpod.
- Logique métier séparée des widgets.
- Responsive mobile/tablette/desktop.
- Animation bonus : le bouton d'ajout au panier utilise `AnimatedSwitcher` pour passer visuellement de « Ajouter au panier » à « Ajouté au panier », complété par un `SnackBar` de confirmation.
- Tests unitaires Riverpod.

## Architecture

```text
lib/
├── main.dart
├── models/
│   └── product.dart
├── data/
│   └── product_repository.dart
├── providers/
│   ├── product_providers.dart
│   ├── favorites_provider.dart
│   ├── cart_provider.dart
│   └── profile_provider.dart
├── router/
│   └── app_router.dart
├── screens/
│   ├── home_screen.dart
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   ├── favorites_screen.dart
│   └── profile_screen.dart
├── theme/
│   └── app_theme.dart
└── widgets/
    ├── app_shell.dart
    ├── product_card.dart
    ├── product_image.dart
    ├── add_to_cart_button.dart
    └── price_text.dart
```

## Providers

1. `productRepositoryProvider`
2. `productsProvider` (`FutureProvider`)
3. `categoriesProvider`
4. `brandsProvider`
5. `searchQueryProvider`
6. `selectedCategoryProvider`
7. `selectedBrandProvider`
8. `sortModeProvider`
9. `filteredProductsProvider`
10. `productByIdProvider`
11. `favoritesProvider` (`NotifierProvider`)
12. `favoriteCountProvider`
13. `cartProvider` (`NotifierProvider`)
14. `cartItemsProvider`
15. `cartCountProvider`
16. `cartSubtotalProvider`
17. `cartShippingProvider`
18. `cartTotalProvider`
19. `profileProvider`

## Lancer le projet

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Pour une release web :

```bash
flutter build web --release
```

Le dossier `build/web` peut ensuite être publié sur GitHub Pages, Firebase Hosting, Netlify ou un autre hébergeur.

## Démonstration du cahier des charges

### Catalogue
Accueil avec recherche, filtres, tri, badges, notes, stock et cartes produits.

### Panier
Ajout, suppression, quantité, sous-total, livraison gratuite à partir de 250 000 FCFA et total.

### Favoris
Les identifiants sont stockés avec `SharedPreferencesAsync`, donc les favoris restent disponibles après rechargement.

### Données asynchrones
`productsProvider` charge le JSON via `ProductRepository.fetchProducts()` et expose un `AsyncValue`. L'UI traite explicitement loading/error/data.

### Séparation des responsabilités
Les modèles, repository, providers et widgets sont dans des couches séparées. Les widgets ne contiennent pas la source du catalogue.

## Note importante

Les images du catalogue sont des URLs de démonstration. Pour une version finale réellement commerciale, remplacez-les par vos propres visuels et ajoutez un backend de paiement/commande sécurisé.

## Auteur

Cheick — Projet Flutter / Web
