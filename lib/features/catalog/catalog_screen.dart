import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../tools/catalog/catalog.dart';
import '../../tools/tool_def.dart';
import '../common/tool_tile.dart';
import '../../l10n/l10n.dart';

/// Discover: every tool by category, with search. Opened from Home's search
/// field and "Browse all tools".
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, this.autofocus = false});

  final bool autofocus;

  static Route<void> route({bool autofocus = false}) =>
      MaterialPageRoute(builder: (_) => CatalogScreen(autofocus: autofocus));

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _query = '';

  bool _matches(ToolDef t) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return t.name.toLowerCase().contains(q) ||
        t.description.toLowerCase().contains(q) ||
        context.l10n.category(t.category).toLowerCase().contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      for (final c in ToolCategory.values)
        (context.l10n.category(c), toolsIn(c).where(_matches).toList()),
    ].where((s) => s.$2.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.catalogTitle(allTools.length))),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.edge,
              4,
              AppSpace.edge,
              8,
            ),
            sliver: SliverToBoxAdapter(
              child: TextField(
                autofocus: widget.autofocus,
                onChanged: (q) => setState(() => _query = q),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: context.l10n.homeSearchLabel,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          if (sections.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text(context.l10n.catalogNoResults)),
            ),
          for (final (title, tools) in sections)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpace.edge,
                16,
                AppSpace.edge,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionLabel(title),
                    ToolTileList(tools: tools),
                  ],
                ),
              ),
            ),
          const SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(child: SizedBox(height: 24)),
          ),
        ],
      ),
    );
  }
}
