import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    final prefs = SharedPreferencesAsync();
    _load(prefs);
    return <String>{};
  }

  Future<void> _load(SharedPreferencesAsync prefs) async {
    final ids = await prefs.getStringList('favorite_product_ids') ?? <String>[];
    state = {...ids};
  }

  Future<void> toggle(String id) async {
    final next = {...state};
    if (!next.add(id)) next.remove(id);
    state = next;
    final prefs = SharedPreferencesAsync();
    await prefs.setStringList('favorite_product_ids', state.toList());
  }

  bool contains(String id) => state.contains(id);
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);

final favoriteCountProvider = Provider<int>((ref) => ref.watch(favoritesProvider).length);