import 'package:flutter/widgets.dart';

import '../core/format.dart';
import '../project/launch_path.dart';
import '../project/project.dart';
import '../tools/catalog/catalog.dart';
import '../tools/tool_def.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';

/// UI strings live in `app_*.arb` (master plan §9), tool text in
/// `tools/l10n/`. Domain enums keep an English `label` for tests; screens
/// and copied text use the localized names below.
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// The 45 tools in the current language. Reading it subscribes the widget
  /// to locale changes, so tool text switches with the language at once.
  ToolCatalog get tools =>
      ToolCatalog.of(Localizations.localeOf(this).languageCode);

  /// Number formatting in the current language.
  Fmt get fmt => Fmt.of(Localizations.localeOf(this).languageCode);
}

/// [text] in capitals, with Turkish dotted and dotless i kept apart.
String upperIn(String text, String language) => language == 'tr'
    ? text.replaceAll('i', 'İ').replaceAll('ı', 'I').toUpperCase()
    : text.toUpperCase();

/// A noun inside a sentence ("Add investor"). German keeps its capital.
String nounIn(String noun, String language) => switch (language) {
  'de' => noun,
  'tr' => noun.replaceAll('I', 'ı').replaceAll('İ', 'i').toLowerCase(),
  _ => noun.toLowerCase(),
};

extension DomainLabels on AppLocalizations {
  String goal(Goal g) => switch (g) {
    Goal.raiseFunding => goalRaiseFunding,
    Goal.firstCustomers => goalFirstCustomers,
    Goal.setUpCompany => goalSetUpCompany,
    Goal.launchApp => goalLaunchApp,
  };

  String goalDetail(Goal g) => switch (g) {
    Goal.raiseFunding => welcomeGoalRaiseFunding,
    Goal.firstCustomers => welcomeGoalFirstCustomers,
    Goal.setUpCompany => welcomeGoalSetUpCompany,
    Goal.launchApp => welcomeGoalLaunchApp,
  };

  String category(ToolCategory c) => switch (c) {
    ToolCategory.ideaValidation => categoryIdeaValidation,
    ToolCategory.finance => categoryFinance,
    ToolCategory.investors => categoryInvestors,
    ToolCategory.product => categoryProduct,
    ToolCategory.marketing => categoryMarketing,
    ToolCategory.sales => categorySales,
    ToolCategory.legal => categoryLegal,
    ToolCategory.team => categoryTeam,
    ToolCategory.growth => categoryGrowth,
    ToolCategory.mobileApp => categoryMobileApp,
  };

  String field(ProjectField f) => switch (f) {
    ProjectField.startupName => fieldStartupName,
    ProjectField.oneLiner => fieldOneLiner,
    ProjectField.problem => fieldProblem,
    ProjectField.solution => fieldSolution,
    ProjectField.targetCustomer => fieldTargetCustomer,
    ProjectField.marketSize => fieldMarketSize,
    ProjectField.traction => fieldTraction,
    ProjectField.ask => fieldAsk,
    ProjectField.team => fieldTeam,
    ProjectField.contactEmail => fieldContactEmail,
    ProjectField.cash => fieldCash,
    ProjectField.monthlyExpenses => fieldMonthlyExpenses,
    ProjectField.monthlyRevenue => fieldMonthlyRevenue,
  };

  String fieldHint(ProjectField f) => switch (f) {
    ProjectField.startupName => hintStartupName,
    ProjectField.oneLiner => hintOneLiner,
    ProjectField.problem => hintProblem,
    ProjectField.solution => hintSolution,
    ProjectField.targetCustomer => hintTargetCustomer,
    ProjectField.marketSize => hintMarketSize,
    ProjectField.traction => hintTraction,
    ProjectField.ask => hintAsk,
    ProjectField.team => hintTeam,
    ProjectField.contactEmail => hintContactEmail,
    ProjectField.cash => hintCash,
    ProjectField.monthlyExpenses => hintMonthlyExpenses,
    ProjectField.monthlyRevenue => hintMonthlyRevenue,
  };

  /// Launch path steps are identified by their position.
  String stepName(LaunchStep s) => switch (launchPath.indexOf(s)) {
    0 => stepIdea,
    1 => stepValidate,
    2 => stepMoney,
    3 => stepPitch,
    _ => stepLaunch,
  };

  String stepAction(LaunchStep s) => switch (launchPath.indexOf(s)) {
    0 => stepIdeaAction,
    1 => stepValidateAction,
    2 => stepMoneyAction,
    3 => stepPitchAction,
    _ => stepLaunchAction,
  };
}
