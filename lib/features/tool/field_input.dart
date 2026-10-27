import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/format.dart';
import '../../core/theme/app_tokens.dart';
import '../../engines/inputs.dart';
import '../../tools/tool_def.dart';
import '../../l10n/l10n.dart';

/// Renders one [FieldDef]. Numeric fields with a min and max become sliders;
/// tapping a slider's value lets the user type an exact number.
class FieldInput extends StatelessWidget {
  const FieldInput({
    super.key,
    required this.field,
    required this.value,
    required this.onChanged,
  });

  final FieldDef field;
  final Object? value;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    if (field.type == FieldType.choice) {
      return _ChoiceInput(field: field, value: value, onChanged: onChanged);
    }
    if (field.isNumeric && field.min != null && field.max != null) {
      return _SliderInput(field: field, value: value, onChanged: onChanged);
    }
    return _TextInput(field: field, value: value, onChanged: onChanged);
  }
}

/// Text shown for a stored value: whole doubles lose their ".0".
String fieldText(Object? value) {
  if (value is double && value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value?.toString() ?? '';
}

/// Display text for a numeric field value ("$14,000", "80%") in the
/// language of [fmt].
String formatFieldValue(FieldDef field, Object? value, Fmt fmt) {
  final n = Inputs.toNumber(value) ?? 0;
  final decimals = n == n.roundToDouble() ? 0 : 1;
  return switch (field.type) {
    FieldType.money => fmt.money(n),
    FieldType.percent => fmt.percent(n / 100, decimals: decimals),
    _ => fmt.number(n, decimals: decimals),
  };
}

class _TextInput extends StatefulWidget {
  const _TextInput({
    required this.field,
    required this.value,
    required this.onChanged,
  });

  final FieldDef field;
  final Object? value;
  final ValueChanged<Object?> onChanged;

  @override
  State<_TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<_TextInput> {
  late final TextEditingController _controller = TextEditingController(
    text: fieldText(widget.value),
  );
  final _focus = FocusNode();

  @override
  void didUpdateWidget(_TextInput old) {
    super.didUpdateWidget(old);
    // Outside changes (reset, project sync) update the text, but never
    // while the user is typing in this field.
    final text = fieldText(widget.value);
    if (!_focus.hasFocus && text != _controller.text) _controller.text = text;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.field;
    final multiline = f.type == FieldType.multiline;
    return TextField(
      controller: _controller,
      focusNode: _focus,
      onChanged: widget.onChanged,
      minLines: multiline ? 2 : 1,
      maxLines: multiline ? 6 : 1,
      keyboardType: switch (f.type) {
        FieldType.email => TextInputType.emailAddress,
        FieldType.multiline => TextInputType.multiline,
        _ when f.isNumeric => const TextInputType.numberWithOptions(
          decimal: true,
        ),
        _ => TextInputType.text,
      },
      inputFormatters: f.isNumeric
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))]
          : null,
      textCapitalization: f.type == FieldType.email
          ? TextCapitalization.none
          : TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: f.label,
        // The example shows how to answer without pretending to be the
        // user's data; it disappears as soon as they type.
        hintText: f.isWritten && fieldText(f.defaultValue).isNotEmpty
            ? context.l10n.commonExample(fieldText(f.defaultValue))
            : null,
        hintMaxLines: multiline ? 4 : 1,
        helperText: f.hint,
        prefixText: f.type == FieldType.money ? '${context.fmt.symbol} ' : null,
        suffixText: f.type == FieldType.percent ? '%' : null,
      ),
    );
  }
}

class _SliderInput extends StatelessWidget {
  const _SliderInput({
    required this.field,
    required this.value,
    required this.onChanged,
  });

  final FieldDef field;
  final Object? value;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    final f = field;
    final t = context.tokens;
    final n = Inputs.toNumber(value) ?? f.min!;
    final step = f.step;
    final divisions = step == null ? null : ((f.max! - f.min!) / step).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                f.label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Semantics(
              button: true,
              label: context.l10n.commonEditField(f.label),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.chip),
                onTap: () => _typeExact(context, n),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: AppSpace.minTouch,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        formatFieldValue(f, n, context.fmt),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 17,
                          color: t.accent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (f.hint != null)
          Text(f.hint!, style: Theme.of(context).textTheme.bodySmall),
        // One VoiceOver element: "Cash in bank, $120,000". The value is
        // already shown above the track, so no value-indicator label.
        MergeSemantics(
          child: Semantics(
            label: f.label,
            child: Slider(
              value: n.clamp(f.min!, f.max!),
              min: f.min!,
              max: f.max!,
              divisions: divisions,
              semanticFormatterCallback: (v) =>
                  formatFieldValue(f, v, context.fmt),
              onChanged: (v) =>
                  onChanged(step != null && step >= 1 ? v.roundToDouble() : v),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _typeExact(BuildContext context, double current) async {
    final controller = TextEditingController(text: fieldText(current));
    final result = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(field.label),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
          ],
          decoration: InputDecoration(
            prefixText: field.type == FieldType.money
                ? '${context.fmt.symbol} '
                : null,
            suffixText: field.type == FieldType.percent ? '%' : null,
          ),
          onSubmitted: (s) => Navigator.pop(context, Inputs.toNumber(s)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, Inputs.toNumber(controller.text)),
            child: Text(context.l10n.commonDone),
          ),
        ],
      ),
    );
    controller.dispose();
    // Typed values may go above the slider's max; the slider just pins.
    if (result != null) onChanged(result);
  }
}

class _ChoiceInput extends StatelessWidget {
  const _ChoiceInput({
    required this.field,
    required this.value,
    required this.onChanged,
  });

  final FieldDef field;
  final Object? value;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSpace.gapS),
        Wrap(
          spacing: AppSpace.gapS,
          runSpacing: AppSpace.gapS,
          children: [
            for (final option in field.options)
              ChoiceChip(
                label: Text(field.optionLabel(option)),
                selected: option == value,
                selectedColor: t.accent,
                labelStyle: TextStyle(
                  color: option == value ? t.onAccent : t.text,
                ),
                showCheckmark: false,
                onSelected: (_) => onChanged(option),
              ),
          ],
        ),
      ],
    );
  }
}
