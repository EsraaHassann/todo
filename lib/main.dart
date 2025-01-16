import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/providers/ThemeProvider.dart';
import 'package:todo/providers/favorites_provider.dart';
import 'firebase_options.dart'; // Generated file for Firebase options
import 'screens/home_screen.dart';
import 'screens/settings_page.dart'; // Settings page
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Correct Firebase options for the platform
    );
  } catch (e) {
    print("Firebase initialization error: $e"); // Log initialization errors
  }

  // Run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Theme provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: themeProvider.themeMode, // Dynamically switch theme
      initialRoute: '/', // Define initial route
      routes: {
        '/': (context) => const HomeScreen(), // Default screen
        '/settings': (context) => const SettingsPage(), // SettingsPage route
      },
    );
  }
}
