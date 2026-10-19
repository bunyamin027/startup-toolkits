import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/motion.dart';
import '../../project/field_mapper.dart';
import '../../project/launch_path.dart';
import '../../project/project.dart';
import '../../project/project_providers.dart';
import '../../tools/catalog/catalog.dart';
import '../../tools/tool_def.dart';
import '../../tools/tool_providers.dart';
import '../common/tool_tile.dart';
import '../tool/tool_actions.dart';
import 'project_sheets.dart';

/// The project workspace: enter startup facts once, every tool reuses them.
class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  bool _allTools = false;

  void _edit(ProjectField field) =>
      showSheet(context, ProjectFieldSheet(field: field));

  @override
  Widget build(BuildContext context) {
    final project = ref.watch(projectProvider);
    final used = ref.watch(recentToolsProvider).keys.toSet();
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final name = project[ProjectField.startupName].trim();
    final missing = ProjectField.values
        .where((f) => !project.isFilled(f))
        .toList();
    final tools = _toolsByFill(project);
    final shownTools = _allTools ? tools : tools.take(5).toList();

    var i = 0;
    Widget rise(Widget child) => RiseIn(index: i++, child: child);

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
          rise(Text('Project', style: text.displaySmall)),
          const SizedBox(height: 16),
          rise(
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Editable(
                    onTap: () => _edit(ProjectField.startupName),
                    label: 'Startup name',
                    child: Text(
                      name.isEmpty ? 'Name your startup' : name,
                      style: text.headlineSmall?.copyWith(
                        color: name.isEmpty ? t.muted : t.text,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  _Editable(
                    onTap: () => _edit(ProjectField.oneLiner),
                    label: 'One-line description',
                    child: Text(
                      project.isFilled(ProjectField.oneLiner)
                          ? project[ProjectField.oneLiner]
                          : 'Add a one-line description',
                      style: text.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: AppSpace.gapS,
                    runSpacing: AppSpace.gapS,
                    children: [
                      ActionChip(
                        avatar: Icon(
                          project.goal == null
                              ? Icons.flag_outlined
                              : goalIcon(project.goal!),
                          size: 18,
                          color: t.accent,
                        ),
                        label: Text(project.goal?.label ?? 'Set a goal'),
                        onPressed: () => showSheet(context, const GoalSheet()),
                      ),
                      for (final step in launchPath)
                        Chip(
                          avatar: Icon(
                            step.isDone(project, used)
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 18,
                            color: step.isDone(project, used)
                                ? t.accent
                                : t.muted,
                          ),
                          label: Text(step.name),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpace.gapL),
          rise(
            AppCard(
              child: Row(
                children: [
                  RingGauge(
                    progress: project.completion,
                    size: 112,
                    stroke: 10,
                    child: Semantics(
                      label:
                          '${project.filledCount} of ${ProjectField.values.length} fields filled',
                      excludeSemantics: true,
                      child: Text(
                        '${project.filledCount}/${ProjectField.values.length}',
                        style: text.titleLarge,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fields filled',
                          style: text.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Every tool fills itself from these.',
                          style: text.bodySmall,
                        ),
                        const SizedBox(height: 10),
                        TextButton.icon(
                          onPressed: project.filledCount == 0
                              ? null
                              : () => copyText(context, project.brief),
                          icon: const Icon(Icons.copy, size: 18),
                          label: const Text('Copy project brief'),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (missing.isNotEmpty) ...[
            const SizedBox(height: 22),
            rise(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionLabel('Add to unlock more'),
                  Wrap(
                    spacing: AppSpace.gapS,
                    runSpacing: AppSpace.gapS,
                    children: [
                      for (final f in missing)
                        ActionChip(
                          avatar: Icon(Icons.add, size: 18, color: t.accent),
                          label: Text(f.label),
                          onPressed: () => _edit(f),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 22),
          rise(
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionLabel('Project details'),
                AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      for (final f in ProjectField.values) ...[
                        if (f != ProjectField.values.first)
                          Divider(height: 1, color: t.border, indent: 18),
                        _FieldRow(
                          field: f,
                          value: project[f],
                          onTap: () => _edit(f),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          rise(
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionLabel('Tools that use your project'),
                ToolTileList(
                  tools: [for (final (tool, _, _) in shownTools) tool],
                  subtitles: {
                    for (final (tool, filled, total) in shownTools)
                      tool.id: '$filled of $total fields from your project',
                  },
                ),
                if (tools.length > 5)
                  TextButton(
                    onPressed: () => setState(() => _allTools = !_allTools),
                    child: Text(
                      _allTools ? 'Show fewer' : 'Show all ${tools.length}',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Tools with project fields, most filled first.
  List<(ToolDef, int, int)> _toolsByFill(Project project) {
    final rows = <(ToolDef, int, int)>[];
    for (final tool in allTools) {
      if (tool.kind == ToolKind.list) continue;
      final mapped = {for (final f in tool.fields) ?FieldMapper.match(f)};
      if (mapped.isEmpty) continue;
      rows.add((tool, mapped.where(project.isFilled).length, mapped.length));
    }
    rows.sort((a, b) {
      final byRatio = (b.$2 / b.$3).compareTo(a.$2 / a.$3);
      return byRatio != 0 ? byRatio : b.$3.compareTo(a.$3);
    });
    return rows;
  }
}

class _Editable extends StatelessWidget {
  const _Editable({
    required this.onTap,
    required this.label,
    required this.child,
  });

  final VoidCallback onTap;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: 'Edit $label',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpace.minTouch),
          child: Align(alignment: Alignment.centerLeft, child: child),
        ),
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.field,
    required this.value,
    required this.onTap,
  });

  final ProjectField field;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final empty = value.trim().isEmpty;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(field.label, style: text.bodySmall),
                  const SizedBox(height: 2),
                  Text(
                    empty ? 'Add' : value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodyMedium?.copyWith(
                      color: empty ? t.accent : t.text,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit_outlined, size: 18, color: t.muted),
          ],
        ),
      ),
    );
  }
}
