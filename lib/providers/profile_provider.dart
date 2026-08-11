import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String name;
  final String email;
  final String city;
  const UserProfile({required this.name, required this.email, required this.city});
}

final profileProvider = Provider<UserProfile>((ref) => const UserProfile(
  name: 'Client TechStore',
  email: 'client@techstore.local',
  city: 'Abidjan',
));

final isCompactLayoutProvider = Provider<bool>((ref) => false);