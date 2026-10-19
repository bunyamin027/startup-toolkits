import '../tools/tool_def.dart';
import 'project.dart';

/// Connects tool fields to project fields by label (master plan §5), so data
/// entered once flows into every tool and back.
abstract final class FieldMapper {
  /// Checked in order; first match wins. Phrases match whole words inside the
  /// lowercased label.
  static const _rules = <(ProjectField, List<String>)>[
    (ProjectField.contactEmail, ['contact email', 'support email', 'email']),
    (
      ProjectField.targetCustomer,
      ['customer segment', 'target customer', 'target audience'],
    ),
    (
      ProjectField.startupName,
      [
        'company name',
        'company',
        'startup name',
        'product name',
        'app name',
        'developer',
      ],
    ),
    (ProjectField.oneLiner, ['one-liner', 'one-line description']),
    (ProjectField.problem, ['problem']),
    (ProjectField.solution, ['solution']),
    (ProjectField.marketSize, ['market size']),
    (ProjectField.traction, ['traction']),
    (ProjectField.ask, ['the ask']),
    (ProjectField.team, ['team']),
    (ProjectField.cash, ['cash']),
    (ProjectField.monthlyExpenses, ['monthly expenses']),
    (ProjectField.monthlyRevenue, ['monthly revenue']),
  ];

  static ProjectField? match(FieldDef field) {
    if (!field.autofill) return null;
    final label = field.label.toLowerCase();
    for (final (target, phrases) in _rules) {
      for (final phrase in phrases) {
        if (RegExp('\\b${RegExp.escape(phrase)}\\b').hasMatch(label)) {
          return target;
        }
      }
    }
    return null;
  }

  /// Project values for the tool's mapped fields. Trackers never auto-fill,
  /// so the company name does not land in a customer form.
  static Map<String, String> prefill(ToolDef tool, Project project) {
    if (tool.kind == ToolKind.list) return const {};
    return {
      for (final f in tool.fields)
        if (match(f) case final target? when project.isFilled(target))
          f.key: project[target],
    };
  }

  /// Opening values: example data overlaid with project data.
  static Map<String, Object?> initialValues(ToolDef tool, Project project) => {
    ...tool.defaults,
    ...prefill(tool, project),
  };

  /// Project fields are text; whole numbers lose the ".0" sliders produce.
  static String asText(Object? value) {
    if (value is double && value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value?.toString().trim() ?? '';
  }

  /// Writes non-empty mapped values from a tool back into the project
  /// (two-way sync).
  static Project writeBack(
    ToolDef tool,
    Map<String, Object?> values,
    Project project,
  ) {
    if (tool.kind == ToolKind.list) return project;
    var result = project;
    for (final f in tool.fields) {
      final target = match(f);
      final value = asText(values[f.key]);
      if (target != null && value.isNotEmpty && value != project[target]) {
        result = result.withValue(target, value);
      }
    }
    return result;
  }
}
