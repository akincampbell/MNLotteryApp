import 'package:flutter/material.dart';
import '../widgets/game_card.dart';
import '../widgets/fade_in.dart';
import '../services/analytics_service.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});
  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  // Mock games — swap images as you add real assets later.
  // Ensure these paths exist in pubspec.yaml under `flutter: assets:`
  final List<Map<String, dynamic>> games = [
    {
      'title': 'Lucky 7 Scratch-Off',
      'image': 'assets/images/lucky7.png', // ok to use .png if that’s what you saved
      'price': r'$5',
      'route': '/game',
      'isNew': true,
    },
    {
      'title': 'Minnesota Gold',
      'image': 'assets/images/lucky7.png',
      'price': r'$10',
      'route': null,
      'isNew': false,
    },
    {
      'title': 'North Star Cash',
      'image': 'assets/images/lucky7.png',
      'price': r'$2',
      'route': null,
      'isNew': false,
    },
    {
      'title': 'Vikings Vault',
      'image': 'assets/images/lucky7.png',
      'price': r'$3',
      'route': null,
      'isNew': false,
    },
  ];

  int _calcCols(double width) {
    if (width >= 1100) return 5;
    if (width >= 900) return 4;
    if (width >= 620) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Catalog'),
      ),
      body: FadeIn(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cols = _calcCols(constraints.maxWidth);
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: games.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, i) {
                final g = games[i];
                return GameCard(
                  title: g['title'] as String,
                  imageAsset: g['image'] as String,
                  price: g['price'] as String,
                  isNew: (g['isNew'] as bool?) ?? false,
                  onTap: () {
                    final route = g['route'] as String?;
                    if (route != null) {
                      AnalyticsService().logEvent(
                        'view_game',
                        params: {'game': g['title'] as String},
                      );
                      Navigator.pushNamed(context, route);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${g['title']} is a demo placeholder.'),
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
