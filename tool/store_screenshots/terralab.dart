import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

/// Terralab, filled in from the R&D example in [lang]: the startup shown
/// in store screenshots and app previews.
Project terralab(String lang) {
  final c = ToolCatalog.of(lang, Sector.rnd);
  String v(String tool, String key) =>
      '${c.byId(tool)!.field(key)!.defaultValue}';
  return const Project(goal: Goal.raiseFunding, sector: Sector.rnd)
      .withValue(ProjectField.startupName, 'Terralab')
      .withValue(ProjectField.oneLiner, v('onePager', 'oneLiner'))
      .withValue(ProjectField.problem, v('onePager', 'problem'))
      .withValue(ProjectField.solution, v('onePager', 'solution'))
      .withValue(ProjectField.targetCustomer, v('onePager', 'customer'))
      .withValue(ProjectField.marketSize, v('onePager', 'market'))
      .withValue(ProjectField.traction, v('onePager', 'traction'))
      .withValue(ProjectField.team, v('onePager', 'team'))
      .withValue(ProjectField.ask, v('onePager', 'ask'))
      .withValue(ProjectField.contactEmail, v('onePager', 'email'))
      .withValue(ProjectField.cash, '480000')
      .withValue(ProjectField.monthlyExpenses, '42000')
      .withValue(ProjectField.monthlyRevenue, '6000');
}
