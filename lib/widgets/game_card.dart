import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final String price;
  final bool isNew;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.price,
    required this.onTap,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      label: 'Game card: $title, price $price',
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, _, __) => Container(
                  color: cs.surfaceVariant,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),

              // Gradient overlay (readable text)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.55),
                      ],
                    ),
                  ),
                ),
              ),

              // Title
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: tt.titleMedium?.copyWith(
                    color: Colors.white,
                    height: 1.2,
                    shadows: const [
                      Shadow(
                        blurRadius: 8,
                        offset: Offset(0, 1),
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),

              // Price chip
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    price,
                    style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                  ),
                ),
              ),

              // NEW badge (optional)
              if (isNew)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: cs.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'NEW',
                      style: tt.labelLarge?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
