import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/motion.dart';
import '../../engines/doc_engine.dart';
import '../../tools/tool_def.dart';
import '../../tools/tool_providers.dart';
import 'field_input.dart';
import 'tool_actions.dart';
import 'tool_screen.dart';
import '../../l10n/l10n.dart';

/// Text generator: Result and Edit tabs over the same values. Opens on the
/// result so the example output is the first thing the user sees.
class DocToolView extends ConsumerStatefulWidget {
  const DocToolView({super.key, required this.tool});

  final ToolDef tool;

  @override
  ConsumerState<DocToolView> createState() => _DocToolViewState();
}

enum _Tab { result, edit }

class _DocToolViewState extends ConsumerState<DocToolView> {
  _Tab _tab = _Tab.result;

  @override
  Widget build(BuildContext context) {
    final tool = widget.tool;
    final values = ref.watch(toolValuesProvider(tool.id)).value;
    if (values == null) return const Center(child: CircularProgressIndicator());

    final notifier = ref.read(toolValuesProvider(tool.id).notifier);
    final output = DocEngine.renderTool(tool, values, fmt: context.fmt);
    final (filled, total) = writtenProgress(tool, values);
    final selector = tool.templateField == null
        ? null
        : tool.field(tool.templateField!);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpace.edge,
            4,
            AppSpace.edge,
            12,
          ),
          child: SizedBox(
            width: double.infinity,
            child: SegmentedButton<_Tab>(
              segments: [
                ButtonSegment(
                  value: _Tab.result,
                  label: Text(context.l10n.toolResult),
                  icon: const Icon(Icons.article_outlined),
                ),
                ButtonSegment(
                  value: _Tab.edit,
                  label: Text(context.l10n.commonEdit),
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
              selected: {_tab},
              showSelectedIcon: false,
              onSelectionChanged: (s) => setState(() => _tab = s.first),
            ),
          ),
        ),
        Expanded(
          child: switch (_tab) {
            _Tab.result => ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpace.edge,
                0,
                AppSpace.edge,
                24,
              ),
              children: [
                // Variant picker stays on the result tab: switching templates
                // is the quickest way to see what the tool can do.
                if (selector != null) ...[
                  FieldInput(
                    field: selector,
                    value: values[selector.key],
                    onChanged: (v) => notifier.set(selector.key, v),
                  ),
                  const SizedBox(height: AppSpace.gapL),
                ],
                if (filled < total) ...[
                  _FillCard(
                    tool: tool,
                    filled: filled,
                    total: total,
                    onFill: () => setState(() => _tab = _Tab.edit),
                  ),
                  const SizedBox(height: AppSpace.gapL),
                ],
                RiseIn(
                  index: 0,
                  child: AppCard(
                    child: SelectableText.rich(
                      outputSpan(
                        output,
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                          height: 1.5,
                          fontSize: 15,
                        ),
                        context.tokens.accent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _Tab.edit => ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpace.edge,
                0,
                AppSpace.edge,
                24,
              ),
              children: [
                for (final f in tool.fields) ...[
                  FieldInput(
                    field: f,
                    value: values[f.key],
                    onChanged: (v) => notifier.set(f.key, v),
                  ),
                  const SizedBox(height: AppSpace.gapL),
                ],
              ],
            ),
          },
        ),
        ToolActionBar(
          toolId: tool.id,
          text: output,
          subject: tool.name,
          onSaveToProject: saveToProjectAction(context, ref, tool),
        ),
      ],
    );
  }
}

/// [output] with its section headings ("2. CUSTOMER SEGMENT",
/// "TOTAL DUE: $1,830") in bold accent; copied text stays plain.
TextSpan outputSpan(String output, TextStyle base, Color heading) {
  final bold = base.copyWith(fontWeight: FontWeight.w700, color: heading);
  final lines = output.split('\n');
  return TextSpan(
    style: base,
    children: [
      for (final (i, line) in lines.indexed)
        TextSpan(
          text: i == lines.length - 1 ? line : '$line\n',
          style: isHeading(line) ? bold : null,
        ),
    ],
  );
}

/// A line whose lead (up to the first colon) is written in capitals and
/// has at least four letters, so "KDV (%8): …" or "Konu: …" are not.
bool isHeading(String line) {
  final t = line.trim();
  if (t.isEmpty || t.startsWith('•')) return false;
  final colon = t.indexOf(':');
  final lead = colon < 0 ? t : t.substring(0, colon);
  final letters = lead.replaceAll(RegExp(r'[^\p{L}]', unicode: true), '');
  return letters.length >= 4 &&
      letters == letters.toUpperCase() &&
      letters != letters.toLowerCase();
}

/// Written fields the current template uses, and how many hold text.
(int, int) writtenProgress(ToolDef tool, Map<String, Object?> values) {
  final used = DocEngine.placeholderKeys(DocEngine.templateFor(tool, values));
  final written = [
    for (final f in tool.fields)
      if (f.isWritten && used.contains(f.key)) f,
  ];
  final filled = written
      .where((f) => fieldText(values[f.key]).trim().isNotEmpty)
      .length;
  return (filled, written.length);
}

/// Shown while the document still has empty fields: says how far along it
/// is and jumps to the Edit tab.
class _FillCard extends StatelessWidget {
  const _FillCard({
    required this.tool,
    required this.filled,
    required this.total,
    required this.onFill,
  });

  final ToolDef tool;
  final int filled;
  final int total;
  final VoidCallback onFill;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    return AppCard(
      color: t.surface2,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.toolFillTitle(filled, total),
                  style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  context.l10n.toolFillBody(tool.name),
                  style: text.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.gapM),
          FilledButton(
            onPressed: onFill,
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, AppSpace.minTouch),
            ),
            child: Text(context.l10n.toolFillAction),
          ),
        ],
      ),
    );
  }
}
