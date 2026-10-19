import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../billing/billing_config.dart';
import '../../billing/entitlement.dart';
import '../../billing/entitlement_providers.dart';
import '../../core/bootstrap.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../project/project_providers.dart';
import '../home/home_screen.dart';
import '../paywall/paywall_screen.dart';
import '../tool/tool_actions.dart';
import '../project/project_sheets.dart';

/// Plan, preferences, legal links and local data.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final t = context.tokens;
    final e = ref.watch(entitlementProvider);
    final now = ref.watch(clockProvider)();
    final goal = ref.watch(projectProvider.select((p) => p.goal));

    final planText = switch (e.level(now)) {
      AccessLevel.trial =>
        'All 45 tools are open during your free trial. '
            '${e.trialDaysLeft(now)} ${e.trialDaysLeft(now) == 1 ? 'day' : 'days'} left.',
      AccessLevel.free =>
        'Free plan: one tool per day. Project and onboarding stay free.',
      AccessLevel.subscriber => 'Pro: every tool, every day.',
    };

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpace.edge,
          12,
          AppSpace.edge,
          32,
        ),
        children: [
          Text('Profile', style: text.displaySmall),
          const SizedBox(height: 20),
          const SectionLabel('Plan'),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PlanBadge(tappable: false),
                const SizedBox(height: 10),
                Text(planText, style: text.bodyMedium),
                const SizedBox(height: 14),
                if (e.level(now) == AccessLevel.subscriber)
                  OutlinedButton(
                    onPressed: () => _open(context, _manageUrl),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('Manage subscription'),
                  )
                else
                  FilledButton(
                    onPressed: () =>
                        Navigator.push(context, PaywallScreen.route()),
                    child: const Text('See plans'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          const SectionLabel('Preferences'),
          _Group(
            children: [
              _Row(
                icon: Icons.flag_outlined,
                title: 'Goal',
                value: goal?.label ?? 'Not set',
                onTap: () => showSheet(context, const GoalSheet()),
              ),
              const _Row(
                icon: Icons.language,
                title: 'Language',
                value: 'English',
                note: 'More languages are coming.',
              ),
              const _Row(
                icon: Icons.dark_mode_outlined,
                title: 'Appearance',
                value: 'Dark',
                note: 'A light theme is coming.',
              ),
              const _Row(
                icon: Icons.motion_photos_off_outlined,
                title: 'Motion',
                value: 'Follows system',
                note:
                    'Turn on Reduce Motion in system settings to stop animations.',
              ),
            ],
          ),
          const SizedBox(height: 26),
          const SectionLabel('Your data'),
          _Group(
            children: [
              const _Row(
                icon: Icons.phone_iphone,
                title: 'Stored on this device',
                note:
                    'No account, no server. Deleting the app deletes your data.',
              ),
              _Row(
                icon: Icons.delete_outline,
                title: 'Delete all data',
                danger: true,
                onTap: () => _confirmDelete(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const SectionLabel('About'),
          _Group(
            children: [
              _Row(
                icon: Icons.restore,
                title: 'Restore purchases',
                onTap: () => _restore(context, ref),
              ),
              _Row(
                icon: Icons.description_outlined,
                title: 'Terms of Use',
                onTap: () => _open(context, BillingConfig.termsUrl),
              ),
              _Row(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () => _open(context, BillingConfig.privacyUrl),
              ),
              const _Row(
                icon: Icons.info_outline,
                title: 'Startup Toolkits',
                value: 'Version 0.1.0',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Legal templates are not legal advice.',
            textAlign: TextAlign.center,
            style: text.bodySmall?.copyWith(color: t.muted),
          ),
        ],
      ),
    );
  }

  static String get _manageUrl =>
      defaultTargetPlatform == TargetPlatform.android
      ? 'https://play.google.com/store/account/subscriptions'
      : 'https://apps.apple.com/account/subscriptions';

  void _open(BuildContext context, String url) {
    if (url.isEmpty) {
      showMessage(context, 'This link is added before release.');
      return;
    }
    unawaited(launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication));
  }

  Future<void> _restore(BuildContext context, WidgetRef ref) async {
    final billing = ref.read(billingServiceProvider);
    if (!billing.available) {
      showMessage(context, 'Purchases are not available right now.');
      return;
    }
    final found = await billing.restore();
    if (found) ref.read(entitlementProvider.notifier).setSubscribed(true);
    if (!context.mounted) return;
    showMessage(
      context,
      found
          ? 'Subscription restored.'
          : 'No active subscription found for this account.',
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all data?'),
        content: const Text(
          'Your project, tool inputs, lists and favorites will be removed from this device. '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(deleteAllDataProvider)();
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(height: 1, color: context.tokens.border, indent: 56),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.title,
    this.value,
    this.note,
    this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final String? value;
  final String? note;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final color = danger ? Theme.of(context).colorScheme.error : t.text;
    return ListTile(
      onTap: onTap,
      minTileHeight: 52,
      leading: Icon(icon, color: danger ? color : t.muted),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
      subtitle: note == null
          ? null
          : Text(note!, style: TextStyle(color: t.muted, fontSize: 13)),
      trailing: value == null && onTap == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (value != null)
                  Text(value!, style: TextStyle(color: t.muted, fontSize: 15)),
                if (onTap != null && !danger)
                  Icon(Icons.chevron_right, color: t.muted),
              ],
            ),
    );
  }
}
