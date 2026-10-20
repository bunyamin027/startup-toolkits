import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/analytics.dart';
import '../../core/format.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/widgets/motion.dart';
import '../../engines/list_engine.dart';
import '../../tools/tool_def.dart';
import '../../tools/tool_providers.dart';
import 'field_input.dart';
import 'tool_actions.dart';
import '../../l10n/l10n.dart';

/// Tracker: stage filter, optional totals, items that move stage by stage.
class ListToolView extends ConsumerStatefulWidget {
  const ListToolView({super.key, required this.tool});

  final ToolDef tool;

  @override
  ConsumerState<ListToolView> createState() => _ListToolViewState();
}

class _ListToolViewState extends ConsumerState<ListToolView> {
  /// Null shows every stage.
  String? _stage;

  ToolDef get tool => widget.tool;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(listItemsProvider(tool.id)).value;
    if (items == null) return const Center(child: CircularProgressIndicator());

    final notifier = ref.read(listItemsProvider(tool.id).notifier);
    final counts = ListEngine.countByStage(items, tool.stages);
    final visible = _stage == null ? items : ListEngine.inStage(items, _stage!);
    final t = context.tokens;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context, null),
        backgroundColor: t.accent,
        foregroundColor: t.onAccent,
        icon: const Icon(Icons.add),
        label: Text(context.l10n.listAddItem(tool.itemLabel.toLowerCase())),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height:
                56 * MediaQuery.textScalerOf(context).scale(1).clamp(1, 1.6),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
              children: [
                _StageChip(
                  label: context.l10n.listAll,
                  count: items.length,
                  selected: _stage == null,
                  onTap: () => setState(() => _stage = null),
                ),
                for (final s in tool.stages)
                  _StageChip(
                    label: s,
                    count: counts[s]!,
                    selected: _stage == s,
                    onTap: () => setState(() => _stage = s),
                  ),
              ],
            ),
          ),
          if (tool.totalField != null) _Totals(tool: tool, items: items),
          Expanded(
            child: visible.isEmpty
                ? _Empty(tool: tool, stage: _stage)
                : ListView.separated(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpace.edge,
                      8,
                      AppSpace.edge,
                      96,
                    ),
                    itemCount: visible.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpace.gapS),
                    itemBuilder: (context, i) {
                      final item = visible[i];
                      return RiseIn(
                        index: i.clamp(0, 8),
                        child: Dismissible(
                          key: ValueKey(item.id),
                          direction: DismissDirection.endToStart,
                          background: _DeleteBackground(),
                          onDismissed: (_) =>
                              _remove(item, items.indexOf(item)),
                          child: _ItemCard(
                            tool: tool,
                            item: item,
                            showStage: _stage == null,
                            onTap: () => _openEditor(context, item),
                            onAdvance: tool.isEndStage(item.stage)
                                ? null
                                : () => notifier.advance(item.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _CopyBar(tool: tool, items: items),
    );
  }

  void _remove(ListItem item, int index) {
    final notifier = ref.read(listItemsProvider(tool.id).notifier)
      ..remove(item.id);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.l10n.listDeleted(item.title)),
          action: SnackBarAction(
            label: context.l10n.commonUndo,
            onPressed: () => notifier.restore(item, index),
          ),
        ),
      );
  }

  Future<void> _openEditor(BuildContext context, ListItem? item) async {
    final result = await showModalBottomSheet<_EditorResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: context.tokens.surface1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.card),
        ),
      ),
      builder: (_) => _ItemEditor(
        tool: tool,
        item: item,
        initialStage: _stage ?? tool.stages.first,
      ),
    );
    if (result == null || !mounted) return;
    final notifier = ref.read(listItemsProvider(tool.id).notifier);
    switch (result) {
      case _Save(:final item):
        item.id.isEmpty
            ? notifier.add(
                ListItem(
                  id: ListItemsNotifier.newId(),
                  title: item.title,
                  stage: item.stage,
                  fields: item.fields,
                ),
              )
            : notifier.edit(item);
      case _Delete(:final item):
        if (mounted) {
          final items = ref.read(listItemsProvider(tool.id)).value ?? const [];
          _remove(item, items.indexWhere((i) => i.id == item.id));
        }
    }
  }
}

/// Text of an item's extra columns, money formatted.
String itemDetails(ToolDef tool, ListItem item) => [
  for (final f in tool.fields)
    if (fieldText(item.fields[f.key]).trim().isNotEmpty)
      f.isNumeric
          ? formatFieldValue(f, item.fields[f.key])
          : fieldText(item.fields[f.key]),
].join(' · ');

class _StageChip extends StatelessWidget {
  const _StageChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpace.gapS),
      child: Center(
        child: ChoiceChip(
          label: Text('$label  $count'),
          selected: selected,
          showCheckmark: false,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          selectedColor: t.accent,
          labelStyle: TextStyle(color: selected ? t.onAccent : t.text),
          onSelected: (_) => onTap(),
        ),
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals({required this.tool, required this.items});

  final ToolDef tool;
  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    final field = tool.field(tool.totalField!)!;
    final text = Theme.of(context).textTheme;
    final parts = [
      for (final s in tool.stages)
        if (ListEngine.inStage(items, s).isNotEmpty)
          '$s ${Fmt.money(ListEngine.total(items, field.key, stage: s))}',
    ];
    if (parts.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpace.edge + 4,
        0,
        AppSpace.edge,
        4,
      ),
      child: Text(
        '${field.label}: ${parts.join(' · ')}',
        style: text.bodySmall,
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    required this.tool,
    required this.item,
    required this.showStage,
    required this.onTap,
    required this.onAdvance,
  });

  final ToolDef tool;
  final ListItem item;
  final bool showStage;
  final VoidCallback onTap;
  final VoidCallback? onAdvance;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final details = itemDetails(tool, item);
    final next = onAdvance == null
        ? null
        : ListEngine.nextStage(item.stage, tool.stages);
    return Material(
      color: t.surface1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.chip),
        side: BorderSide(color: t.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 6, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: text.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (details.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(details, style: text.bodySmall),
                    ],
                    if (showStage) ...[
                      const SizedBox(height: 6),
                      Text(
                        item.stage.toUpperCase(),
                        style: text.labelSmall?.copyWith(color: t.blue),
                      ),
                    ],
                  ],
                ),
              ),
              if (next != null)
                IconButton(
                  tooltip: context.l10n.listMoveTo(next),
                  onPressed: onAdvance,
                  icon: Icon(Icons.arrow_forward_rounded, color: t.accent),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: t.muted,
                    semanticLabel: context.l10n.listFinalStage,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      padding: const EdgeInsetsDirectional.only(end: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.tool, required this.stage});

  final ToolDef tool;
  final String? stage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          stage == null
              ? context.l10n.listEmpty
              : context.l10n.listEmptyStage(stage!),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}

class _CopyBar extends ConsumerWidget {
  const _CopyBar({required this.tool, required this.items});

  final ToolDef tool;
  final List<ListItem> items;

  String get _text => [
    tool.name.toUpperCase(),
    for (final s in tool.stages)
      if (ListEngine.inStage(items, s).isNotEmpty) ...[
        '',
        s.toUpperCase(),
        for (final i in ListEngine.inStage(items, s))
          [
            '• ${i.title}',
            if (itemDetails(tool, i).isNotEmpty) itemDetails(tool, i),
          ].join(' · '),
      ],
  ].join('\n');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.read(analyticsProvider);
    final t = context.tokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: t.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            children: [
              TextButton.icon(
                onPressed: () {
                  analytics.log(AnalyticsEvent.outputCopied, {'tool': tool.id});
                  copyText(context, _text);
                },
                icon: const Icon(Icons.copy, size: 18),
                label: Text(context.l10n.listCopy),
              ),
              Builder(
                builder: (context) => TextButton.icon(
                  onPressed: () {
                    analytics.log(AnalyticsEvent.outputShared, {
                      'tool': tool.id,
                    });
                    shareText(context, _text, subject: tool.name);
                  },
                  icon: const Icon(Icons.ios_share, size: 18),
                  label: Text(context.l10n.commonShare),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

sealed class _EditorResult {}

class _Save extends _EditorResult {
  _Save(this.item);
  final ListItem item;
}

class _Delete extends _EditorResult {
  _Delete(this.item);
  final ListItem item;
}

/// Add or edit one item. New items come back with an empty id.
class _ItemEditor extends StatefulWidget {
  const _ItemEditor({
    required this.tool,
    required this.item,
    required this.initialStage,
  });

  final ToolDef tool;
  final ListItem? item;
  final String initialStage;

  @override
  State<_ItemEditor> createState() => _ItemEditorState();
}

class _ItemEditorState extends State<_ItemEditor> {
  late final _title = TextEditingController(text: widget.item?.title ?? '');
  late String _stage = widget.item?.stage ?? widget.initialStage;
  late final Map<String, Object?> _fields = {...?widget.item?.fields};

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  void _save() {
    final title = _title.text.trim();
    if (title.isEmpty) return;
    final base = widget.item;
    Navigator.pop(
      context,
      _Save(
        ListItem(
          id: base?.id ?? '',
          title: title,
          stage: _stage,
          fields: _fields,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tool = widget.tool;
    final editing = widget.item != null;
    final stageField = FieldDef(
      key: '_stage',
      label: context.l10n.listStage,
      type: FieldType.choice,
      options: tool.stages,
    );
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.edge,
          20,
          AppSpace.edge,
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              editing
                  ? context.l10n.listEditItem(tool.itemLabel.toLowerCase())
                  : context.l10n.listNewItem(tool.itemLabel.toLowerCase()),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _title,
              autofocus: !editing,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: tool.itemLabel),
              onSubmitted: (_) => _save(),
            ),
            for (final f in tool.fields) ...[
              const SizedBox(height: AppSpace.gapL),
              // Item columns are free entry; the catalog's example values are
              // shown as hints instead of being prefilled.
              FieldInput(
                field: FieldDef(
                  key: f.key,
                  label: f.label,
                  type: f.type,
                  options: f.options,
                  hint:
                      f.hint ??
                      context.l10n.commonExample(fieldText(f.defaultValue)),
                ),
                value: _fields[f.key],
                onChanged: (v) => _fields[f.key] = v,
              ),
            ],
            const SizedBox(height: AppSpace.gapL),
            FieldInput(
              field: stageField,
              value: _stage,
              onChanged: (v) => setState(() => _stage = v! as String),
            ),
            const SizedBox(height: 24),
            ListenableBuilder(
              listenable: _title,
              builder: (context, _) => FilledButton(
                onPressed: _title.text.trim().isEmpty ? null : _save,
                child: Text(
                  editing ? context.l10n.commonSave : context.l10n.commonAdd,
                ),
              ),
            ),
            if (editing) ...[
              const SizedBox(height: AppSpace.gapS),
              TextButton.icon(
                onPressed: () => Navigator.pop(context, _Delete(widget.item!)),
                icon: const Icon(Icons.delete_outline),
                label: Text(context.l10n.commonDelete),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
