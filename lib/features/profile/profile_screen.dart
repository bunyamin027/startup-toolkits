import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../billing/billing_config.dart';
import '../../billing/entitlement.dart';
import '../../billing/entitlement_providers.dart';
import '../../core/app_info.dart';
import '../../core/bootstrap.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/widgets/app_card.dart';
import '../../project/project_providers.dart';
import '../home/home_screen.dart';
import '../paywall/paywall_screen.dart';
import '../tool/tool_actions.dart';
import '../project/project_sheets.dart';
import '../../l10n/l10n.dart';
import '../../tools/catalog/catalog.dart';

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
    final l = context.l10n;

    final planText = switch (e.level(now)) {
      AccessLevel.trial => l.profilePlanTrial(
        e.trialDaysLeft(now),
        allTools.length,
      ),
      AccessLevel.free => l.profilePlanFree,
      AccessLevel.subscriber => l.profilePlanPro,
    };

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.edge,
          12,
          AppSpace.edge,
          32,
        ),
        children: [
          Text(l.profileTitle, style: text.displaySmall),
          const SizedBox(height: 20),
          SectionLabel(l.profilePlan),
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
                    child: Text(l.profileManageSubscription),
                  )
                else
                  FilledButton(
                    onPressed: () =>
                        Navigator.push(context, PaywallScreen.route()),
                    child: Text(l.commonSeePlans),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          SectionLabel(l.profilePreferences),
          _Group(
            children: [
              _Row(
                icon: Icons.flag_outlined,
                title: l.profileGoal,
                value: goal == null ? l.profileNotSet : l.goal(goal),
                onTap: () => showSheet(context, const GoalSheet()),
              ),
              _Row(
                icon: Icons.language,
                title: l.profileLanguage,
                value: l.profileLanguageValue,
                note: l.profileLanguageNote,
              ),
              _Row(
                icon: Icons.dark_mode_outlined,
                title: l.profileAppearance,
                value: l.profileAppearanceValue,
                note: l.profileAppearanceNote,
              ),
              _Row(
                icon: Icons.motion_photos_off_outlined,
                title: l.profileMotion,
                value: l.profileMotionValue,
                note: l.profileMotionNote,
              ),
            ],
          ),
          const SizedBox(height: 26),
          SectionLabel(l.profileYourData),
          _Group(
            children: [
              _Row(
                icon: Icons.phone_iphone,
                title: l.profileStoredOnDevice,
                note: l.profileStoredOnDeviceNote,
              ),
              _Row(
                icon: Icons.delete_outline,
                title: l.profileDeleteAll,
                danger: true,
                onTap: () => _confirmDelete(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 26),
          SectionLabel(l.profileAbout),
          _Group(
            children: [
              _Row(
                icon: Icons.restore,
                title: l.profileRestore,
                onTap: () => _restore(context, ref),
              ),
              _Row(
                icon: Icons.description_outlined,
                title: l.termsOfUse,
                onTap: () => _open(context, BillingConfig.termsUrl),
              ),
              _Row(
                icon: Icons.privacy_tip_outlined,
                title: l.privacyPolicy,
                onTap: () => _open(context, BillingConfig.privacyUrl),
              ),
              _Row(
                icon: Icons.info_outline,
                title: AppInfo.name,
                value: l.profileVersion(AppInfo.version),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l.profileLegalNote,
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
      showMessage(context, context.l10n.commonLinkMissing);
      return;
    }
    unawaited(launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication));
  }

  Future<void> _restore(BuildContext context, WidgetRef ref) async {
    final billing = ref.read(billingServiceProvider);
    if (!billing.available) {
      showMessage(context, context.l10n.purchasesUnavailable);
      return;
    }
    final found = await billing.restore();
    if (found) ref.read(entitlementProvider.notifier).setSubscribed(true);
    if (!context.mounted) return;
    showMessage(
      context,
      found ? context.l10n.restoreSuccess : context.l10n.restoreNothing,
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.profileDeleteAllTitle),
        content: Text(context.l10n.profileDeleteAllBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(context.l10n.commonDelete),
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
