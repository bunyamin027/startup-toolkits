import '../tool_def.dart';
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

/// All 45 tools, in category order (master plan §3).
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
