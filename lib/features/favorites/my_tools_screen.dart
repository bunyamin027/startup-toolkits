import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../tools/catalog/catalog.dart';
import '../../tools/tool_providers.dart';
import '../catalog/catalog_screen.dart';
import '../common/tool_tile.dart';

/// Favorites and recently used tools.
class MyToolsScreen extends ConsumerWidget {
  const MyToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final t = context.tokens;
    final favorites = ref.watch(favoritesProvider);
    ref.watch(recentToolsProvider);
    final recent = ref.read(recentToolsProvider.notifier).ordered.take(8);
    // Catalog order keeps favorites stable while starring and unstarring.
    final favTools = allTools
        .where((tool) => favorites.contains(tool.id))
        .toList();
    final recentTools = [for (final id in recent) ?toolById(id)];

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpace.edge,
          12,
          AppSpace.edge,
          32,
        ),
        children: [
          Text('My tools', style: text.displaySmall),
          const SizedBox(height: 20),
          const SectionLabel('Favorites'),
          if (favTools.isEmpty)
            AppCard(
              child: Row(
                children: [
                  Icon(Icons.star_outline_rounded, color: t.accent),
                  const SizedBox(width: AppSpace.gapM),
                  Expanded(
                    child: Text(
                      'Tap the star in any tool to keep it here.',
                      style: text.bodySmall,
                    ),
                  ),
                ],
              ),
            )
          else
            ToolTileList(tools: favTools),
          const SizedBox(height: 26),
          const SectionLabel('Recently used'),
          if (recentTools.isEmpty)
            AppCard(
              child: Text(
                'Tools you open will show up here.',
                style: text.bodySmall,
              ),
            )
          else
            ToolTileList(tools: recentTools),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(context, CatalogScreen.route()),
            icon: const Icon(Icons.apps),
            label: Text('Browse all ${allTools.length} tools'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
