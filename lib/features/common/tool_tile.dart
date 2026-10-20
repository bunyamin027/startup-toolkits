import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../tools/tool_def.dart';
import '../tool/open_tool.dart';
import '../../l10n/l10n.dart';

/// Tool row used by Home, Discover, My tools and Project.
class ToolTile extends ConsumerWidget {
  const ToolTile({super.key, required this.tool, this.subtitle, this.trailing});

  final ToolDef tool;

  /// Replaces the tool description (e.g. "5 of 9 fields from your project").
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final locked = isToolLocked(ref, tool.id);
    return Material(
      color: t.surface1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.chip),
        side: BorderSide(color: t.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openTool(context, ref, tool.id),
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
                    Text(subtitle ?? tool.description, style: text.bodySmall),
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    locked ? Icons.lock_outline : Icons.chevron_right,
                    color: t.muted,
                    semanticLabel: locked ? context.l10n.toolLocked : null,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Vertical list of [ToolTile]s with standard spacing.
class ToolTileList extends StatelessWidget {
  const ToolTileList({
    super.key,
    required this.tools,
    this.subtitles = const {},
  });

  final List<ToolDef> tools;
  final Map<String, String> subtitles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < tools.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpace.gapS),
          ToolTile(tool: tools[i], subtitle: subtitles[tools[i].id]),
        ],
      ],
    );
  }
}
