import '../l10n/calc_text.dart';
import '../l10n/finance_text.dart';
import '../l10n/growth_text.dart';
import '../l10n/idea_validation_text.dart';
import '../l10n/investors_text.dart';
import '../l10n/legal_text.dart';
import '../l10n/marketing_text.dart';
import '../l10n/mobile_app_text.dart';
import '../l10n/product_text.dart';
import '../l10n/sales_text.dart';
import '../l10n/team_text.dart';
import '../l10n/tool_text.dart';
import '../tool_def.dart';
import '../scenarios/scenario.dart';
import 'finance.dart';
import 'growth.dart';
import 'idea_validation.dart';
import 'investors.dart';
import 'legal.dart';
import 'marketing.dart';
import 'mobile_app.dart';
import 'product.dart';
import 'sales.dart';
import 'team.dart';

/// All 45 tools in English, in category order (master plan §3).
final List<ToolDef> allTools = [
  ...ideaValidationTools,
  ...financeTools,
  ...investorTools,
  ...productTools,
  ...marketingTools,
  ...salesTools,
  ...legalTools,
  ...teamTools,
  ...growthTools,
  ...mobileAppTools,
];

final Map<String, ToolDef> _byId = {for (final t in allTools) t.id: t};

ToolDef? toolById(String id) => _byId[id];

List<ToolDef> toolsIn(ToolCategory category) =>
    allTools.where((t) => t.category == category).toList();

/// Tool translations per category, each keyed by language then tool id.
const _texts = [
  ideaValidationText,
  financeText,
  investorsText,
  productText,
  marketingText,
  salesText,
  legalText,
  teamText,
  growthText,
  mobileAppText,
];

/// Languages with translated tools, English first.
const toolLanguages = ['en', 'tr', 'fr', 'es', 'de'];

/// Trackers whose sample rows are a useful starting template (onboarding
/// steps) rather than made-up people and deals. Only these keep their
/// samples once the user has a project.
const templateSampleTools = {'onboardingChecklist'};

/// Translations of [language] by tool id; empty for English.
Map<String, ToolText> toolTextsIn(String language) => {
  for (final category in _texts) ...?category[language],
};

/// The 45 tools with their text in one language and the examples of one
/// scenario. Screens get theirs from `context.tools`, so a language or
/// scenario change redraws them at once. Without a [sector] the base
/// (software) scenario is used, as written in the catalog files.
class ToolCatalog {
  ToolCatalog._(this.language, this.tools)
    : _index = {for (final t in tools) t.id: t};

  factory ToolCatalog.of(String language, [Sector sector = Sector.saas]) {
    final lang = toolLanguages.contains(language) ? language : 'en';
    return _catalogs['$lang|${sector.name}'] ??= () {
      final texts = toolTextsIn(lang);
      final calc = calcTexts[lang];
      return ToolCatalog._(lang, [
        for (final t in allTools)
          applyScenario(
            lang == 'en' ? t : localizeTool(t, lang, texts[t.id], calc),
            sector,
            lang,
          ),
      ]);
    }();
  }

  static final _catalogs = <String, ToolCatalog>{};

  final String language;
  final List<ToolDef> tools;
  final Map<String, ToolDef> _index;

  ToolDef? byId(String id) => _index[id];

  List<ToolDef> inCategory(ToolCategory category) =>
      tools.where((t) => t.category == category).toList();
}

/// Example value of a field in every language. A saved value that equals
/// one of them was never edited, so it follows the current language.
Set<Object?> examplesOf(String toolId, String fieldKey) => {
  for (final language in toolLanguages)
    for (final sector in Sector.values)
      ToolCatalog.of(
        language,
        sector,
      ).byId(toolId)?.field(fieldKey)?.defaultValue,
};

/// The sample row at [index] in every language and scenario.
List<SampleItem> sampleVariants(String toolId, int index) => [
  for (final language in toolLanguages)
    for (final sector in Sector.values)
      if (ToolCatalog.of(language, sector).byId(toolId)?.samples case final s?
          when index < s.length)
        s[index],
];
