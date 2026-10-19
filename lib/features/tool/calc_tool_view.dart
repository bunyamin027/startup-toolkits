import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/motion.dart';
import '../../engines/calc_engine.dart';
import '../../tools/tool_def.dart';
import '../../tools/tool_providers.dart';
import 'field_input.dart';
import 'tool_actions.dart';
import 'tool_screen.dart';

/// Calculator: big result at the top, inputs below, live updates.
class CalcToolView extends ConsumerWidget {
  const CalcToolView({super.key, required this.tool});

  final ToolDef tool;

  /// Months fill the ring against an 18-month benchmark (a common target
  /// runway between rounds).
  static const ringMonths = 18.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(toolValuesProvider(tool.id)).value;
    if (values == null) return const Center(child: CircularProgressIndicator());

    final notifier = ref.read(toolValuesProvider(tool.id).notifier);
    final result = CalcEngine.run(tool.formula!, values);
    final heroKey = tool.heroOutput ?? result.outputs.first.key;
    final hero = result.outputs.firstWhere((o) => o.key == heroKey);
    final rest = result.outputs.where((o) => o.key != heroKey).toList();

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.edge,
              4,
              AppSpace.edge,
              24,
            ),
            children: [
              RiseIn(
                index: 0,
                child: _Hero(output: hero, verdict: result.verdict),
              ),
              const SizedBox(height: AppSpace.gapL),
              if (rest.isNotEmpty)
                RiseIn(
                  index: 1,
                  child: AppCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < rest.length; i++) ...[
                          if (i > 0)
                            Divider(height: 1, color: context.tokens.border),
                          _ResultRow(output: rest[i]),
                        ],
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 22),
              RiseIn(
                index: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionLabel('Inputs'),
                    AppCard(
                      child: Column(
                        children: [
                          for (var i = 0; i < tool.fields.length; i++) ...[
                            if (i > 0) const SizedBox(height: AppSpace.gapL),
                            FieldInput(
                              field: tool.fields[i],
                              value: values[tool.fields[i].key],
                              onChanged: (v) =>
                                  notifier.set(tool.fields[i].key, v),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ToolActionBar(
          text: _summary(result, values),
          subject: tool.name,
          onSaveToProject: saveToProjectAction(context, ref, tool),
        ),
      ],
    );
  }

  String _summary(CalcResult result, Map<String, Object?> values) {
    final lines = [
      tool.name.toUpperCase(),
      '',
      for (final f in tool.fields)
        '${f.label}: ${formatFieldValue(f, values[f.key])}',
      '',
      for (final o in result.outputs) '${o.label}: ${o.display}',
      if (result.verdict != null) ...['', result.verdict!],
    ];
    return lines.join('\n');
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.output, this.verdict});

  final CalcOutput output;
  final String? verdict;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    String format(double v) =>
        CalcOutput(output.key, output.label, v, output.format).display;

    final number = Semantics(
      label: '${output.label}: ${output.display}',
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: CountUp(
              value: output.value,
              format: format,
              style: text.titleLarge?.copyWith(fontSize: 38, height: 1.1),
            ),
          ),
          const SizedBox(height: 4),
          Text(output.label, style: text.bodySmall),
        ],
      ),
    );

    final ring = switch (output.format) {
      ValueFormat.months => output.value / CalcToolView.ringMonths,
      ValueFormat.percent => output.value,
      _ => null,
    };

    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 18),
      child: Column(
        children: [
          if (ring != null)
            RingGauge(
              progress: ring,
              child: Padding(padding: const EdgeInsets.all(28), child: number),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: number,
            ),
          if (verdict != null) ...[
            const SizedBox(height: AppSpace.gapL),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: t.surface2,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(
                verdict!,
                style: TextStyle(color: t.accent, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.output});

  final CalcOutput output;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return MergeSemantics(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Row(
          children: [
            Expanded(child: Text(output.label, style: text.bodyMedium)),
            Text(
              output.display,
              style: text.titleLarge?.copyWith(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
