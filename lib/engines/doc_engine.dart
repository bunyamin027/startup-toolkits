import 'dart:math' as math;

import '../core/format.dart';
import '../tools/tool_def.dart';
import 'inputs.dart';

/// Renders text-generator tools (master plan §9).
///
/// Template syntax:
/// - `{key}`: the field value. Empty values render as `[Label]` so gaps are
///   visible in the output instead of silently disappearing.
/// - `{=expr}` / `{=expr|format}`: arithmetic over numeric fields, e.g.
///   `{=qty1 * price1 + qty2 * price2|money}`. Supports + - * / ( ),
///   unary minus and round(x), min(a, b), max(a, b).
///   Formats: money, percent (expects a ratio), number (default), int.
abstract final class DocEngine {
  static const legalNotice =
      'Template only, not legal advice. Have a lawyer review it before use.';

  static final _placeholder = RegExp(r'\{(=?)([^{}]+)\}');

  /// Picks the template for the tool's current choice and renders it.
  static String renderTool(ToolDef tool, Map<String, Object?> values) {
    final template = templateFor(tool, values);
    final labels = {for (final f in tool.fields) f.key: f.label};
    final body = render(template, values, labels: labels);
    return tool.legalDisclaimer ? '$body\n\n$legalNotice' : body;
  }

  static String templateFor(ToolDef tool, Map<String, Object?> values) {
    if (tool.templates.isEmpty) return tool.template ?? '';
    final selector = tool.templateField!;
    final chosen =
        values[selector]?.toString() ??
        tool.field(selector)?.defaultValue?.toString();
    return tool.templates[chosen] ?? tool.templates.values.first;
  }

  static String render(
    String template,
    Map<String, Object?> values, {
    Map<String, String> labels = const {},
  }) {
    final inputs = Inputs(values);
    return template.replaceAllMapped(_placeholder, (m) {
      final body = m[2]!.trim();
      if (m[1] == '=') return _evaluate(body, inputs);
      final value = values[body]?.toString().trim() ?? '';
      return value.isEmpty ? '[${labels[body] ?? body}]' : value;
    });
  }

  static String _evaluate(String body, Inputs inputs) {
    final pipe = body.lastIndexOf('|');
    final expr = pipe < 0 ? body : body.substring(0, pipe);
    final format = pipe < 0 ? 'number' : body.substring(pipe + 1).trim();
    final value = evaluate(expr, inputs);
    return switch (format) {
      'money' => Fmt.money(value),
      'percent' => Fmt.percent(value),
      'int' => Fmt.number(value),
      'number' => Fmt.number(
        value,
        decimals: value == value.roundToDouble() ? 0 : 2,
      ),
      _ => throw FormatException('Unknown format "$format"'),
    };
  }

  /// Evaluates an arithmetic expression. Throws [FormatException] on syntax
  /// errors, which are template bugs and are caught by tool catalog tests.
  static double evaluate(String expr, Inputs inputs) =>
      _Parser(expr, inputs).parse();
}

/// Recursive-descent parser: expr := term (('+'|'-') term)*,
/// term := unary (('*'|'/') unary)*, unary := '-' unary | primary.
class _Parser {
  _Parser(this.src, this.inputs);

  final String src;
  final Inputs inputs;
  int pos = 0;

  double parse() {
    final v = _expr();
    _skipSpace();
    if (pos != src.length) _fail('unexpected "${src[pos]}"');
    return v;
  }

  double _expr() {
    var v = _term();
    while (true) {
      if (_eat('+')) {
        v += _term();
      } else if (_eat('-')) {
        v -= _term();
      } else {
        return v;
      }
    }
  }

  double _term() {
    var v = _unary();
    while (true) {
      if (_eat('*')) {
        v *= _unary();
      } else if (_eat('/')) {
        final d = _unary();
        v = d == 0 ? 0 : v / d;
      } else {
        return v;
      }
    }
  }

  double _unary() => _eat('-') ? -_unary() : _primary();

  double _primary() {
    _skipSpace();
    if (_eat('(')) {
      final v = _expr();
      if (!_eat(')')) _fail('missing ")"');
      return v;
    }
    final number = RegExp(r'\d+(\.\d+)?').matchAsPrefix(src, pos);
    if (number != null) {
      pos = number.end;
      return double.parse(number[0]!);
    }
    final ident = RegExp(r'[A-Za-z_]\w*').matchAsPrefix(src, pos);
    if (ident == null) _fail('expected a value');
    pos = ident.end;
    final name = ident[0]!;
    if (!_eat('(')) return inputs.n(name);

    final args = [_expr()];
    while (_eat(',')) {
      args.add(_expr());
    }
    if (!_eat(')')) _fail('missing ")" after $name');
    return switch ((name, args.length)) {
      ('round', 1) => args[0].roundToDouble(),
      ('min', 2) => math.min(args[0], args[1]),
      ('max', 2) => math.max(args[0], args[1]),
      _ => _fail('unknown function $name/${args.length}'),
    };
  }

  bool _eat(String token) {
    _skipSpace();
    if (src.startsWith(token, pos)) {
      pos += token.length;
      return true;
    }
    return false;
  }

  void _skipSpace() {
    while (pos < src.length && src[pos] == ' ') {
      pos++;
    }
  }

  Never _fail(String message) =>
      throw FormatException('$message in "{=$src}"', src, pos);
}
