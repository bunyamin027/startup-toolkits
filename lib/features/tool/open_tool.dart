import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../billing/entitlement_providers.dart';
import '../../core/analytics.dart';
import '../paywall/free_limit_sheet.dart';
import 'tool_screen.dart';

/// Single entry point for opening a tool. On the free plan, a tool other
/// than today's shows the free limit sheet instead (master plan §6).
Future<void> openTool(
  BuildContext context,
  WidgetRef ref,
  String toolId,
) async {
  final now = ref.read(clockProvider)();
  final entitlement = ref.read(entitlementProvider);
  if (!entitlement.canOpen(toolId, now)) {
    ref.read(analyticsProvider).log(AnalyticsEvent.freeLimitHit, {
      'tool': toolId,
    });
    await showFreeLimitSheet(
      context,
      todaysToolId: entitlement.todaysTool(now),
    );
    return;
  }
  ref.read(analyticsProvider).log(AnalyticsEvent.toolOpened, {'tool': toolId});
  await Navigator.push(context, ToolScreen.route(toolId));
}

/// Whether a lock should show on the tool's tile (free plan, not today's).
bool isToolLocked(WidgetRef ref, String toolId) {
  final now = ref.watch(clockProvider)();
  return !ref.watch(entitlementProvider).canOpen(toolId, now);
}
