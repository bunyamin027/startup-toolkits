import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../tools/catalog/catalog.dart';
import '../../tools/tool_def.dart';
import '../../tools/tool_providers.dart';
import '../tool/tool_screen.dart';

/// Every tool by category, with search. Serves as the start screen until
/// Home ("Mission control") lands in Sprint 3; later it backs search.
class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  String _query = '';

  bool _matches(ToolDef t) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return t.name.toLowerCase().contains(q) ||
        t.description.toLowerCase().contains(q) ||
        t.category.label.toLowerCase().contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    final text = Theme.of(context).textTheme;
    final sections = [
      if (favorites.isNotEmpty && _query.isEmpty)
        ('Favorites', allTools.where((t) => favorites.contains(t.id)).toList()),
      for (final c in ToolCategory.values)
        (c.label, toolsIn(c).where(_matches).toList()),
    ].where((s) => s.$2.isNotEmpty).toList();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpace.edge,
                16,
                AppSpace.edge,
                8,
              ),
              sliver: SliverList.list(
                children: [
                  Text('Startup Toolkits', style: text.displaySmall),
                  const SizedBox(height: 4),
                  Text(
                    '${allTools.length} tools for founders',
                    style: text.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (q) => setState(() => _query = q),
                    decoration: const InputDecoration(
                      hintText: 'Search tools',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            if (sections.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('No tools match your search.')),
              ),
            for (final (title, tools) in sections)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpace.edge,
                  16,
                  AppSpace.edge,
                  0,
                ),
                sliver: SliverList.list(
                  children: [
                    SectionLabel(title),
                    for (final t in tools) ...[
                      _ToolRow(tool: t),
                      const SizedBox(height: AppSpace.gapS),
                    ],
                  ],
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

class _ToolRow extends StatelessWidget {
  const _ToolRow({required this.tool});

  final ToolDef tool;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    return Material(
      color: t.surface1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.chip),
        side: BorderSide(color: t.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(context, ToolScreen.route(tool.id)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              IconBox(tool.icon),
              const SizedBox(width: AppSpace.gapM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tool.name,
                      style: text.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(tool.description, style: text.bodySmall),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: t.muted),
            ],
          ),
        ),
      ),
    );
  }
}
