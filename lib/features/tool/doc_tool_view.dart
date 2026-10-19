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
    final output = DocEngine.renderTool(tool, values);
    final selector = tool.templateField == null
        ? null
        : tool.field(tool.templateField!);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.edge,
            4,
            AppSpace.edge,
            12,
          ),
          child: SizedBox(
            width: double.infinity,
            child: SegmentedButton<_Tab>(
              segments: const [
                ButtonSegment(
                  value: _Tab.result,
                  label: Text('Result'),
                  icon: Icon(Icons.article_outlined),
                ),
                ButtonSegment(
                  value: _Tab.edit,
                  label: Text('Edit'),
                  icon: Icon(Icons.edit_outlined),
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
              padding: const EdgeInsets.fromLTRB(
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
                RiseIn(
                  index: 0,
                  child: AppCard(
                    child: SelectableText(
                      output,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _Tab.edit => ListView(
              padding: const EdgeInsets.fromLTRB(
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
