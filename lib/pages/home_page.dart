import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../services/auth_service.dart';
import '../services/analytics_service.dart';
import '../widgets/fade_in.dart';
import '../widgets/demo_ribbon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _openResponsiblePlay() async {
    final uri = Uri.parse('https://www.mnlottery.com/');
    await url_launcher.launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/bird_logo.jpg',
              width: 28,
              height: 28,
              semanticLabel: 'MN Lottery demo bird logo',
            ),
            const SizedBox(width: 8),
            const Text('MN Lottery — Demo'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Analytics',
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () => Navigator.pushNamed(context, '/analytics'),
          ),
          IconButton(
            tooltip: 'Campaigns',
            icon: const Icon(Icons.campaign_outlined),
            onPressed: () => Navigator.pushNamed(context, '/campaigns'),
          ),
          IconButton(
            tooltip: 'Health',
            icon: const Icon(Icons.verified_user_outlined),
            onPressed: () => Navigator.pushNamed(context, '/health'),
          ),
          IconButton(
            tooltip: 'Sign Out',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              await AnalyticsService().logEvent('logout');
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FadeIn(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // HERO / HEADER
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        cs.primaryContainer,
                        cs.primary.withOpacity(0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome row
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/bird_logo.jpg',
                            width: 40,
                            height: 40,
                            semanticLabel: 'MN Lottery demo bird logo',
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Welcome ${user?.email ?? 'Player'}',
                            style: tt.titleLarge?.copyWith(
                              color: cs.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Jackpot banner (mock)
                      Text(
                        'Powerball: \$120M • Mega Millions: \$94M',
                        style: tt.titleMedium?.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Primary CTAs
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.icon(
                            onPressed: () {
                              AnalyticsService().logEvent('nav_catalog');
                              Navigator.pushNamed(context, '/catalog');
                            },
                            icon: const Icon(Icons.grid_view_rounded),
                            label: const Text('Game Catalog'),
                          ),
                          FilledButton.icon(
                            onPressed: () {
                              AnalyticsService().logEvent('nav_second_chance');
                              Navigator.pushNamed(context, '/second');
                            },
                            icon: const Icon(Icons.qr_code_2_rounded),
                            label: const Text('Second Chance'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Prototype — Not an official MN Lottery app',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // What's New card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("What's New",
                            style: tt.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            )),
                        const SizedBox(height: 8),
                        const Text(
                          '• Polished UI theme (Material 3)\n'
                          '• Always-visible DEMO ribbon\n'
                          '• Catalog grid and Lucky 7 demo\n'
                          '• Second-chance entry (mock) + CSV export (web)\n'
                          '• Mock analytics & CRM sends',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Responsible Play / Resources
                TextButton.icon(
                  onPressed: _openResponsiblePlay,
                  icon: const Icon(Icons.help_outline),
                  label: const Text('Responsible Play & Resources'),
                ),
              ],
            ),
          ),

          // Persistent prototype ribbon
          const DemoRibbon(),
        ],
      ),
    );
  }
}
