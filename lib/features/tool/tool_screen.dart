import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../billing/entitlement_providers.dart';
import '../../project/field_mapper.dart';
import '../../tools/catalog/catalog.dart';
import '../../tools/tool_def.dart';
import '../../tools/tool_providers.dart';
import 'calc_tool_view.dart';
import 'doc_tool_view.dart';
import 'list_tool_view.dart';
import 'tool_actions.dart';
import '../../l10n/l10n.dart';

/// One screen for all 45 tools; the body depends on the tool's engine.
class ToolScreen extends ConsumerStatefulWidget {
  const ToolScreen({super.key, required this.toolId});

  final String toolId;

  static Route<void> route(String toolId) =>
      MaterialPageRoute(builder: (_) => ToolScreen(toolId: toolId));

  @override
  ConsumerState<ToolScreen> createState() => _ToolScreenState();
}

class _ToolScreenState extends ConsumerState<ToolScreen> {
  String get toolId => widget.toolId;

  @override
  void initState() {
    super.initState();
    // Providers cannot change during build; record the open right after.
    Future.microtask(() {
      if (!mounted || toolById(toolId) == null) return;
      ref.read(recentToolsProvider.notifier).record(toolId);
      ref.read(entitlementProvider.notifier).open(toolId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tool = context.tools.byId(toolId);
    if (tool == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(context.l10n.toolNotFound)),
      );
    }
    final favorite = ref.watch(
      favoritesProvider.select((f) => f.contains(toolId)),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(tool.name),
        backgroundColor: Colors.transparent,
        actions: [
          if (tool.kind != ToolKind.list)
            PopupMenuButton<String>(
              tooltip: context.l10n.commonMore,
              onSelected: (_) {
                ref.read(toolValuesProvider(toolId).notifier).reset();
                showMessage(context, context.l10n.toolResetDone);
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'reset',
                  child: Text(context.l10n.toolReset),
                ),
              ],
            ),
          IconButton(
            tooltip: favorite
                ? context.l10n.toolFavoriteRemove
                : context.l10n.toolFavoriteAdd,
            icon: Icon(
              favorite ? Icons.star_rounded : Icons.star_outline_rounded,
            ),
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggle(toolId),
          ),
        ],
      ),
      body: switch (tool.kind) {
        ToolKind.calc => CalcToolView(tool: tool),
        ToolKind.doc => DocToolView(tool: tool),
        ToolKind.list => ListToolView(tool: tool),
      },
    );
  }
}

/// Shared "Save to project" handler, or null when the tool has no project
/// fields.
VoidCallback? saveToProjectAction(
  BuildContext context,
  WidgetRef ref,
  ToolDef tool,
) {
  final mapped = tool.fields.any((f) => FieldMapper.match(f) != null);
  if (!mapped) return null;
  return () {
    final changed = ref
        .read(toolValuesProvider(tool.id).notifier)
        .saveToProject();
    showMessage(
      context,
      changed == 0
          ? context.l10n.toolProjectUpToDate
          : context.l10n.toolSavedFields(changed),
    );
  };
}
