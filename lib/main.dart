import 'package:flutter/material.dart';
import 'config.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/catalog_page.dart';
import 'pages/game_page.dart';
import 'pages/second_chance_page.dart';
import 'pages/analytics_page.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: uri_does_not_exist
import 'firebase_options.dart' as firebase_options;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kMockMode) {
    try {
      await Firebase.initializeApp(
        options: firebase_options.DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint('Firebase init failed: $e');
    }
  }
  runApp(const LotteryDemoApp());
}

class LotteryDemoApp extends StatelessWidget {
  const LotteryDemoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MN Lottery Demo (Prototype)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(kPrimaryColorHex)),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
        '/catalog': (_) => const CatalogPage(),
        '/game': (_) => const GamePage(),
        '/second': (_) => const SecondChancePage(),
        '/analytics': (_) => const AnalyticsPage(),
      },
    );
  }
}
