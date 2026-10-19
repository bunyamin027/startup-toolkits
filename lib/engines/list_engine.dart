import 'package:flutter/foundation.dart';

import 'inputs.dart';

/// One row of a tracker (investor, lead, task, ...).
@immutable
class ListItem {
  const ListItem({
    required this.id,
    required this.title,
    required this.stage,
    this.fields = const {},
  });

  factory ListItem.fromJson(Map<String, Object?> json) => ListItem(
    id: json['id']! as String,
    title: json['title']! as String,
    stage: json['stage']! as String,
    fields: Map<String, Object?>.from(json['fields']! as Map),
  );

  final String id;
  final String title;
  final String stage;

  /// Extra columns, e.g. amount, price, owner.
  final Map<String, Object?> fields;

  ListItem copyWith({
    String? title,
    String? stage,
    Map<String, Object?>? fields,
  }) => ListItem(
    id: id,
    title: title ?? this.title,
    stage: stage ?? this.stage,
    fields: fields ?? this.fields,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'stage': stage,
    'fields': fields,
  };
}

/// Immutable operations for tracker tools. Each returns a new list so state
/// management can compare by identity.
abstract final class ListEngine {
  static List<ListItem> add(List<ListItem> items, ListItem item) => [
    ...items,
    item,
  ];

  static List<ListItem> remove(List<ListItem> items, String id) =>
      items.where((i) => i.id != id).toList();

  static List<ListItem> update(List<ListItem> items, ListItem item) => [
    for (final i in items) i.id == item.id ? item : i,
  ];

  static List<ListItem> moveTo(List<ListItem> items, String id, String stage) =>
      [for (final i in items) i.id == id ? i.copyWith(stage: stage) : i];

  /// Moves an item to the next stage; items in the last stage stay put.
  static List<ListItem> advance(
    List<ListItem> items,
    String id,
    List<String> stages,
  ) {
    return [
      for (final i in items)
        if (i.id == id) i.copyWith(stage: nextStage(i.stage, stages)) else i,
    ];
  }

  static String nextStage(String stage, List<String> stages) {
    final index = stages.indexOf(stage);
    if (index < 0) return stages.first;
    return stages[(index + 1).clamp(0, stages.length - 1)];
  }

  static List<ListItem> inStage(List<ListItem> items, String stage) =>
      items.where((i) => i.stage == stage).toList();

  /// Item count per stage, in stage order, including empty stages.
  static Map<String, int> countByStage(
    List<ListItem> items,
    List<String> stages,
  ) => {for (final s in stages) s: items.where((i) => i.stage == s).length};

  /// Sum of a numeric column, optionally limited to one stage
  /// (e.g. committed investor amounts).
  static double total(List<ListItem> items, String field, {String? stage}) =>
      items
          .where((i) => stage == null || i.stage == stage)
          .map((i) => Inputs.toNumber(i.fields[field]) ?? 0)
          .fold(0, (a, b) => a + b);
}
