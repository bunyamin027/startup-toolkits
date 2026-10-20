import 'dart:math' as math;

import '../core/format.dart';
import '../tools/tool_def.dart';
import 'inputs.dart';

/// Renders text-generator tools (master plan §9).
///
/// Template syntax:
/// - `{key}`: the field value. Empty values render as `[Label]` so gaps are
///   visible in the output instead of silently disappearing.
/// - `{key|filter}`: cap, lower, upper, tag (no spaces, words capitalized),
///   slug (url-safe), first (first word), bullets (one "• " per line),
///   money, number.
/// - `{=expr}` / `{=expr|format}`: arithmetic over numeric fields, e.g.
///   `{=qty1 * price1 + qty2 * price2|money}`. Supports + - * / ( ),
///   unary minus and round(x), min(a, b), max(a, b).
///   Formats: money, percent (expects a ratio), number (default), int.
abstract final class DocEngine {
  static const legalNotice =
      'Template only, not legal advice. Have a lawyer review it before use.';

  static const _legalNotices = {
    'en': legalNotice,
    'tr':
        'Yalnızca şablondur, hukuki tavsiye değildir. Kullanmadan önce bir avukata inceletin.',
    'fr':
        'Modèle uniquement, pas un conseil juridique. Faites-le relire par un avocat avant usage.',
    'es':
        'Solo es una plantilla, no asesoramiento legal. Haz que un abogado la revise antes de usarla.',
    'de':
        'Nur eine Vorlage, keine Rechtsberatung. Lass sie vor der Nutzung von einer Anwältin oder einem Anwalt prüfen.',
  };

  /// [legalNotice] in [language]; English when there is no translation.
  static String legalNoticeIn(String language) =>
      _legalNotices[language] ?? legalNotice;

  static final _placeholder = RegExp(r'\{(=?)([^{}]+)\}');

  /// Picks the template for the tool's current choice and renders it in
  /// the tool's language.
  static String renderTool(ToolDef tool, Map<String, Object?> values) {
    final template = templateFor(tool, values);
    final labels = {for (final f in tool.fields) f.key: f.label};
    // Choices are stored in English; the text shows them translated.
    final shown = {
      ...values,
      for (final f in tool.fields)
        if (f.type == FieldType.choice && values[f.key] is String)
          f.key: f.optionLabel(values[f.key]! as String),
    };
    final body = render(
      template,
      shown,
      labels: labels,
      fmt: Fmt.of(tool.language),
    );
    return tool.legalDisclaimer
        ? '$body\n\n${legalNoticeIn(tool.language)}'
        : body;
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
    Fmt? fmt,
  }) {
    final inputs = Inputs(values);
    final f = fmt ?? Fmt.en;
    return template.replaceAllMapped(_placeholder, (m) {
      final body = m[2]!.trim();
      if (m[1] == '=') return _evaluate(body, inputs, f);
      final pipe = body.indexOf('|');
      final key = pipe < 0 ? body : body.substring(0, pipe).trim();
      final value = _text(values[key]);
      if (value.isEmpty) return '[${labels[key] ?? key}]';
      return pipe < 0
          ? value
          : applyFilter(body.substring(pipe + 1).trim(), value, f);
    });
  }

  static String _text(Object? raw) {
    if (raw is double && raw == raw.roundToDouble()) {
      return raw.toInt().toString();
    }
    return raw?.toString().trim() ?? '';
  }

  static String applyFilter(String filter, String value, [Fmt? fmt]) {
    final f = fmt ?? Fmt.en;
    final words = value.split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    String cap(String w) => w[0].toUpperCase() + w.substring(1);
    return switch (filter) {
      'cap' => cap(value),
      'lower' => value.toLowerCase(),
      'upper' => value.toUpperCase(),
      'tag' => words.map(cap).join().replaceAll(RegExp(r'[^\w]'), ''),
      'slug' => _ascii(
        value.toLowerCase(),
      ).replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), ''),
      'first' => words.first,
      'bullets' =>
        value
            .split('\n')
            .map((l) => l.trim())
            .where((l) => l.isNotEmpty)
            .map((l) => '• $l')
            .join('\n'),
      'money' => f.money(Inputs.toNumber(value) ?? 0),
      'number' => f.number(Inputs.toNumber(value) ?? 0),
      _ => throw FormatException('Unknown filter "$filter"'),
    };
  }

  static const _accents = {
    'à': 'a',
    'á': 'a',
    'â': 'a',
    'ä': 'a',
    'ç': 'c',
    'è': 'e',
    'é': 'e',
    'ê': 'e',
    'ë': 'e',
    'ğ': 'g',
    'ı': 'i',
    'î': 'i',
    'ï': 'i',
    'í': 'i',
    'ñ': 'n',
    'ó': 'o',
    'ô': 'o',
    'ö': 'o',
    'ş': 's',
    'ß': 'ss',
    'ù': 'u',
    'ú': 'u',
    'û': 'u',
    'ü': 'u',
    'œ': 'oe',
  };

  /// Slugs stay readable in every language: "Çiçek" -> "cicek".
  static String _ascii(String value) =>
      value.split('').map((c) => _accents[c] ?? c).join();

  /// Keys referenced by `{key}` / `{key|filter}` placeholders, for catalog
  /// tests that check every placeholder has a field.
  static Set<String> placeholderKeys(String template) => {
    for (final m in _placeholder.allMatches(template))
      if (m[1] != '=') m[2]!.split('|').first.trim(),
  };

  /// Variables referenced by `{=expr}` placeholders.
  static Set<String> expressionVariables(String template) {
    const functions = {'round', 'min', 'max'};
    final out = <String>{};
    for (final m in _placeholder.allMatches(template)) {
      if (m[1] != '=') continue;
      final expr = m[2]!.split('|').first;
      for (final v in RegExp(r'[A-Za-z_]\w*').allMatches(expr)) {
        if (!functions.contains(v[0])) out.add(v[0]!);
      }
    }
    return out;
  }

  static String _evaluate(String body, Inputs inputs, Fmt fmt) {
    final pipe = body.lastIndexOf('|');
    final expr = pipe < 0 ? body : body.substring(0, pipe);
    final format = pipe < 0 ? 'number' : body.substring(pipe + 1).trim();
    final value = evaluate(expr, inputs);
    return switch (format) {
      'money' => fmt.money(value),
      'percent' => fmt.percent(value),
      'int' => fmt.number(value),
      'number' => fmt.number(
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
