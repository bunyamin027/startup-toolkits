import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/app_tokens.dart';

Future<void> copyText(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) return;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
}

/// Opens the system share sheet. [context] anchors the iPad popover.
Future<void> shareText(
  BuildContext context,
  String text, {
  String? subject,
}) async {
  final box = context.findRenderObject() as RenderBox?;
  await SharePlus.instance.share(
    ShareParams(
      text: text,
      subject: subject,
      sharePositionOrigin: box == null
          ? null
          : box.localToGlobal(Offset.zero) & box.size,
    ),
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Bottom bar of calculators and generators: the "copy or save" half of
/// "enter, see the result, copy or save".
class ToolActionBar extends StatelessWidget {
  const ToolActionBar({
    super.key,
    required this.text,
    required this.subject,
    this.onSaveToProject,
  });

  final String text;
  final String subject;

  /// Null hides the button (tool has no project fields).
  final VoidCallback? onSaveToProject;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: t.bg,
        border: Border(top: BorderSide(color: t.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.edge,
            10,
            AppSpace.edge,
            10,
          ),
          child: Row(
            children: [
              if (onSaveToProject != null)
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onSaveToProject,
                    icon: const Icon(Icons.bookmark_add_outlined),
                    label: const Text('Save to project'),
                  ),
                )
              else
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => copyText(context, text),
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy'),
                  ),
                ),
              const SizedBox(width: AppSpace.gapS),
              if (onSaveToProject != null)
                _SquareButton(
                  icon: Icons.copy,
                  label: 'Copy',
                  onPressed: () => copyText(context, text),
                ),
              const SizedBox(width: AppSpace.gapS),
              Builder(
                builder: (context) => _SquareButton(
                  icon: Icons.ios_share,
                  label: 'Share',
                  onPressed: () => shareText(context, text, subject: subject),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  const _SquareButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return IconButton(
      onPressed: onPressed,
      tooltip: label,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        fixedSize: const Size(52, 52),
        backgroundColor: t.surface2,
        foregroundColor: t.text,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
    );
  }
}
