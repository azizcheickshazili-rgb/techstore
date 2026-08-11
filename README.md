# TechStore — Flutter Web e-commerce

TechStore est une boutique web de matériel informatique développée avec Flutter et Riverpod. Le catalogue est chargé de manière asynchrone depuis un JSON local afin de démontrer les états `loading`, `data` et `error` dans l'interface.

## Fonctionnalités

- Catalogue informatique : ordinateurs, écrans, stockage, mémoire et périphériques.
- Liste et détail des produits.
- Recherche textuelle.
- Filtrage par catégorie et marque.
- Tri par prix et note.
- Panier : ajout, suppression, quantités, sous-total, livraison et total.
- Favoris persistants localement avec `shared_preferences`.
- Profil utilisateur mock.
- Gestion explicite des états de chargement et d'erreur avec `AsyncValue`.
- Bouton Réessayer après une erreur de chargement.
- Animation `AnimatedSwitcher` lors de l'ajout au panier.
- Interface responsive pour mobile, tablette et desktop.

## Architecture

```text
lib/
├── data/
│   └── product_repository.dart
├── models/
│   └── product.dart
├── providers/
│   ├── cart_provider.dart
│   ├── favorites_provider.dart
│   ├── product_providers.dart
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
    ├── add_to_cart_button.dart
    ├── app_shell.dart
    ├── price_text.dart
    ├── product_card.dart
    └── product_image.dart
```

## Providers Riverpod

Le projet utilise exclusivement Riverpod pour l'état applicatif :

1. `productRepositoryProvider` — accès aux données.
2. `productsProvider` — chargement asynchrone du catalogue avec `FutureProvider`.
3. `categoriesProvider` — catégories disponibles.
4. `brandsProvider` — marques disponibles.
5. `searchQueryProvider` — recherche.
6. `selectedCategoryProvider` — catégorie active.
7. `selectedBrandProvider` — marque active.
8. `sortModeProvider` — mode de tri.
9. `filteredProductsProvider` — catalogue filtré/trié.
10. `productByIdProvider` — produit par identifiant avec `family`.
11. `cartProvider` — état métier du panier avec `NotifierProvider`.
12. `cartItemsProvider` — lignes du panier.
13. `cartCountProvider` — nombre d'articles.
14. `cartSubtotalProvider` — sous-total.
15. `cartShippingProvider` — frais de livraison.
16. `cartTotalProvider` — total.
17. `favoritesProvider` — favoris persistants avec `NotifierProvider`.
18. `favoriteCountProvider` — compteur de favoris.
19. `profileProvider` — profil mock.

## Données

Les produits sont dans `assets/data/products.json`. Le repository ajoute volontairement un court délai afin que l'état de chargement soit observable pendant la démonstration.

## Installation

```bash
flutter pub get
flutter analyze
flutter test
flutter build web --release
flutter run -d chrome
```

## CI

GitHub Actions exécute automatiquement :

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter build web --release`

## Note de sécurité

Aucune clé API ou token GitHub n'est nécessaire dans l'application. Les tokens GitHub servent uniquement à l'authentification Git et ne doivent jamais être placés dans le code source.

## Configuration Flutter Web

Le dépôt contient volontairement le dossier `web/` afin que le projet soit reconnu comme une application Flutter Web dès le checkout.

La CI vérifie la présence de `web/index.html` avant de lancer :

```bash
flutter build web --release
```

Aucune API key n'est nécessaire : le catalogue est chargé depuis `assets/data/products.json`.
