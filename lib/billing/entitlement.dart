import 'package:flutter/foundation.dart';

import '../core/storage/key_value_store.dart';

enum AccessLevel { trial, free, subscriber }

/// Who may open which tool (master plan §6).
///
/// - First 14 days after first launch: everything open.
/// - Subscriber: everything open.
/// - Otherwise free plan: the first tool opened today becomes "today's tool"
///   and stays open all day; any other tool shows the paywall. Resets at
///   local midnight.
///
/// DEFAULT (open decision #3, trial type): the trial is tracked in-app from
/// first launch, as in the prototype. If a store-based trial is chosen,
/// set [trialLength] to zero and let [subscribed] cover the store trial.
/// DEFAULT (open decision #4, free plan): "1 tool per day" as written.
@immutable
class Entitlement {
  const Entitlement({
    this.firstLaunch,
    this.subscribed = false,
    this.dailyToolId,
    this.dailyDate,
  });

  factory Entitlement.fromJson(Map<String, Object?> json) => Entitlement(
    firstLaunch: DateTime.tryParse(json['firstLaunch'] as String? ?? ''),
    subscribed: json['subscribed'] == true,
    dailyToolId: json['dailyToolId'] as String?,
    dailyDate: json['dailyDate'] as String?,
  );

  static const trialLength = Duration(days: 14);

  final DateTime? firstLaunch;

  /// Mirrors the store entitlement; billing (Sprint 4) keeps it current.
  final bool subscribed;
  final String? dailyToolId;

  /// Local date (yyyy-mm-dd) [dailyToolId] was claimed on.
  final String? dailyDate;

  DateTime? get trialEndsAt => firstLaunch?.add(trialLength);

  AccessLevel level(DateTime now) {
    if (subscribed) return AccessLevel.subscriber;
    final end = trialEndsAt;
    if (end == null || now.isBefore(end)) return AccessLevel.trial;
    return AccessLevel.free;
  }

  /// Whole days left in the trial, rounded up; 0 once it is over.
  int trialDaysLeft(DateTime now) {
    final end = trialEndsAt;
    if (end == null) return trialLength.inDays;
    final left = end.difference(now);
    if (left <= Duration.zero) return 0;
    return (left.inMinutes / Duration.minutesPerDay).ceil();
  }

  /// Today's tool on the free plan, or null if none is claimed yet today.
  String? todaysTool(DateTime now) =>
      dailyDate == dateKey(now) ? dailyToolId : null;

  bool canOpen(String toolId, DateTime now) {
    if (level(now) != AccessLevel.free) return true;
    final today = todaysTool(now);
    return today == null || today == toolId;
  }

  /// Records an open. On the free plan this claims today's tool.
  /// Callers check [canOpen] first; opening a locked tool is a bug.
  Entitlement open(String toolId, DateTime now) {
    if (!canOpen(toolId, now)) {
      throw StateError('$toolId is locked until ${nextReset(now)}');
    }
    if (level(now) != AccessLevel.free || todaysTool(now) != null) return this;
    return copyWith(dailyToolId: toolId, dailyDate: dateKey(now));
  }

  /// Next local midnight, when the daily tool resets.
  static DateTime nextReset(DateTime now) =>
      DateTime(now.year, now.month, now.day + 1);

  static String dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  Entitlement copyWith({
    DateTime? firstLaunch,
    bool? subscribed,
    String? dailyToolId,
    String? dailyDate,
  }) => Entitlement(
    firstLaunch: firstLaunch ?? this.firstLaunch,
    subscribed: subscribed ?? this.subscribed,
    dailyToolId: dailyToolId ?? this.dailyToolId,
    dailyDate: dailyDate ?? this.dailyDate,
  );

  Map<String, Object?> toJson() => {
    'firstLaunch': firstLaunch?.toIso8601String(),
    'subscribed': subscribed,
    'dailyToolId': dailyToolId,
    'dailyDate': dailyDate,
  };
}

class EntitlementStore {
  EntitlementStore(this._kv);

  static const _key = 'entitlement.v1';

  final KeyValueStore _kv;

  /// Loads the entitlement, starting the trial clock on first launch.
  Future<Entitlement> load(DateTime now) async {
    final json = await _kv.readJson(_key);
    if (json is Map<String, Object?>) {
      final e = Entitlement.fromJson(json);
      if (e.firstLaunch != null) return e;
    }
    final fresh = Entitlement(firstLaunch: now);
    await save(fresh);
    return fresh;
  }

  Future<void> save(Entitlement e) => _kv.writeJson(_key, e.toJson());
}
