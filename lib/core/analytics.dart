import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Funnel events from master plan §9. Names are snake_case so they map 1:1
/// to Firebase Analytics or PostHog when a backend is chosen.
enum AnalyticsEvent {
  onboardingGoalSelected('onboarding_goal_selected'),
  projectCreated('project_created'),
  toolOpened('tool_opened'),
  outputCopied('output_copied'),
  outputShared('output_shared'),
  paywallViewed('paywall_viewed'),
  planSelected('plan_selected'),
  trialStarted('trial_started'),
  subscribed('subscribed'),
  subscriptionEnded('subscription_ended'),
  freeLimitHit('free_limit_hit');

  const AnalyticsEvent(this.wireName);
  final String wireName;
}

abstract class Analytics {
  void log(AnalyticsEvent event, [Map<String, Object> params = const {}]);
}

/// Default until a backend is picked: prints in debug, silent in release.
/// No personal data is sent anywhere, so no tracking prompt is needed.
class DebugAnalytics implements Analytics {
  @override
  void log(AnalyticsEvent event, [Map<String, Object> params = const {}]) {
    if (kDebugMode) debugPrint('[analytics] ${event.wireName} $params');
  }
}

/// Keeps events in memory; used by tests.
class RecordingAnalytics implements Analytics {
  final events = <(AnalyticsEvent, Map<String, Object>)>[];

  Iterable<AnalyticsEvent> get names => events.map((e) => e.$1);

  @override
  void log(AnalyticsEvent event, [Map<String, Object> params = const {}]) =>
      events.add((event, params));
}

final analyticsProvider = Provider<Analytics>((ref) => DebugAnalytics());
