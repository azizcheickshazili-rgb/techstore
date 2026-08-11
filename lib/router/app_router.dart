import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/app_shell.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '/');
  if (uri.path == '/product' && uri.queryParameters['id'] != null) {
    return MaterialPageRoute(builder: (_) => ProductDetailScreen(id: uri.queryParameters['id']!));
  }
  if (uri.path.startsWith('/product/')) {
    return MaterialPageRoute(builder: (_) => ProductDetailScreen(id: uri.pathSegments.last));
  }
  switch (uri.path) {
    case '/cart': return MaterialPageRoute(builder: (_) => const CartScreen());
    case '/favorites': return MaterialPageRoute(builder: (_) => const FavoritesScreen());
    case '/profile': return MaterialPageRoute(builder: (_) => const ProfileScreen());
    default: return MaterialPageRoute(builder: (_) => AppShell(child: const HomeScreen()));
  }
}