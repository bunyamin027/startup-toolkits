import 'package:flutter/foundation.dart';

import '../l10n/tool_text.dart';
import '../tool_def.dart';
import 'ecommerce.dart';
import 'mobile_app.dart';
import 'rnd.dart';

/// Example text of one scenario in one language, by tool id.
///
/// The base catalog is the software (SaaS) scenario. Other scenarios only
/// list what differs: field examples that describe the startup (problem,
/// customers, features, people) and the text of tracker sample rows. Dates,
/// numbers and legal terms stay as in the base. A missing entry falls back
/// to the scenario's English, then to the base catalog;
/// `test/scenario_test.dart` checks each language covers the English.
@immutable
class ScenarioText {
  const ScenarioText({this.fields = const {}, this.samples = const {}});

  /// Example value by tool id, then field key.
  final Map<String, Map<String, String>> fields;

  /// Sample rows by tool id, one per base sample, in the same order.
  /// Numbers and stages come from the base row.
  final Map<String, List<SampleText>> samples;
}

/// Scenario text by sector, then language.
const scenarioTexts = <Sector, Map<String, ScenarioText>>{
  Sector.rnd: rndScenario,
  Sector.ecommerce: ecommerceScenario,
  Sector.mobileApp: mobileAppScenario,
};

/// [tool] (already in [language]) with the examples of [sector].
ToolDef applyScenario(ToolDef tool, Sector sector, String language) {
  final texts = scenarioTexts[sector];
  if (texts == null) return tool;
  final local = texts[language];
  final english = texts['en'];
  final fields = {...?english?.fields[tool.id], ...?local?.fields[tool.id]};
  final rows = local?.samples[tool.id] ?? english?.samples[tool.id];
  if (fields.isEmpty && rows == null) return tool;
  return tool.translated(
    language: tool.language,
    name: tool.name,
    description: tool.description,
    fields: [
      for (final f in tool.fields)
        fields.containsKey(f.key) ? f.copyWith(defaultValue: fields[f.key]) : f,
    ],
    samples: rows == null
        ? null
        : [
            for (final (i, s) in tool.samples.indexed)
              if (i < rows.length)
                SampleItem(rows[i].title, s.stage, {
                  ...s.fields,
                  ...rows[i].fields,
                })
              else
                s,
          ],
    stageLabels: tool.stageLabels,
    outputLabels: tool.outputLabels,
    verdictLabels: tool.verdictLabels,
  );
}
