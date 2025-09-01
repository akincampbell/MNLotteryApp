import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

import '../services/analytics_service.dart';
import '../widgets/fade_in.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _scratcherKey = GlobalKey<ScratcherState>();
  bool _revealed = false;

  // Simple deterministic demo grid — shows a win to make the demo satisfying.
  // You can randomize this later if you want.
  final List<int> _grid = const [7, 2, 3, 4, 7, 1, 5, 6, 7];
  final int _prizeCents = 50000; // $500.00 demo win

  @override
  void initState() {
    super.initState();
    AnalyticsService().logEvent('view_game', params: {'game': 'Lucky 7'});
  }

  void _onThreshold() {
    if (_revealed) return;
    setState(() => _revealed = true);
    final isWin = _grid.contains(7);
    AnalyticsService().logEvent('play_demo', params: {
      'game': 'Lucky 7',
      'win': isWin,
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isWin ? 'You revealed a 7!' : 'No 7s this time'),
          content: Text(
            isWin
                ? 'Demo prize: \$${(_prizeCents / 100).toStringAsFixed(2)}'
                : 'Try another ticket in the demo.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _revealed = false);
                _scratcherKey.currentState?.reset(
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _gridWidget() {
    final cs = Theme.of(context).colorScheme;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, i) {
        final n = _grid[i];
        final is7 = n == 7;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: is7
                ? Colors.amber.shade300.withOpacity(0.85)
                : cs.surfaceVariant,
          ),
          child: Center(
            child: Text(
              '$n',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: is7 ? Colors.black87 : null,
                  ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Lucky 7 Scratch-Off (Demo)')),
      body: FadeIn(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Hero image for the game
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/lucky7.png'), // or .png
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Quick facts
            Row(
              children: [
                Chip(
                  label: const Text('\$5 Ticket'),
                  backgroundColor: cs.primaryContainer,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: const Text('Top Prize: \$77,777'),
                  backgroundColor: cs.secondaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Scratcher area
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: _gridWidget(),
                ),
                IgnorePointer(
                  ignoring: _revealed,
                  child: Scratcher(
                    key: _scratcherKey,
                    brushSize: 35,
                    threshold: 55, // % scratched before onThreshold triggers
                    color: Colors.grey.shade400,
                    onThreshold: _onThreshold,
                    child: Container(), // transparent overlay
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              'How to Play (Demo): Scratch to reveal the numbers. Reveal 7s to win.',
              style: tt.bodySmall,
            ),
            const SizedBox(height: 8),

            const Text(
              'Prototype & Demo Only — Not an official MN Lottery app.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
