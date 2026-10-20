import 'package:flutter/widgets.dart';

import '../project/launch_path.dart';
import '../project/project.dart';
import '../tools/tool_def.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';

/// UI strings live in `app_*.arb` (master plan §9). Domain enums keep an
/// English `label` for copied text and tests; screens show the localized
/// names below.
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

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
