import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Scaffold(appBar: AppBar(title: const Text('Mon profil')), body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 650), child: Card(margin: const EdgeInsets.all(28), child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42)),
      const SizedBox(height: 18),
      Text(profile.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
      const SizedBox(height: 5),
      Text(profile.email, style: const TextStyle(color: Colors.grey)),
      const Divider(height: 35),
      ListTile(leading: const Icon(Icons.location_on_outlined), title: const Text('Ville'), subtitle: Text(profile.city)),
      const ListTile(leading: Icon(Icons.verified_user_outlined), title: Text('Compte'), subtitle: Text('Profil de démonstration')),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fonctionnalité de connexion simulée.'))), icon: const Icon(Icons.login), label: const Text('Se connecter'))),
    ]))))));
  }
}