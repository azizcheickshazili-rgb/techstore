import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: TechStoreApp()));
}

class TechStoreApp extends StatelessWidget {
  const TechStoreApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TechStore',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    onGenerateRoute: onGenerateRoute,
    initialRoute: '/',
  );
}