import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Assuming you are using GoRouter for routing
import '../../config/theme/light_theme.dart'; // Import LightTheme
import '../../screens/home/home_screen.dart'; // Make sure to import your home screen or other initial screen
import '../../config/routes/app_navigation_router.dart';
import '../../screens/auth/login_screen.dart';

// 1. Define your routesProvider
final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/', // Starting route
    routes: [
      // Define routes here
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(), // Home screen as the entry point
      ),
      // Add more routes as necessary
    ],
  );
});

// 2. Define your TodoApp widget
class TodoApp extends ConsumerWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: LightTheme.theme, // Correctly reference LightTheme.theme
      routerConfig: route,
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: TodoApp(),
    ),
  );
}
