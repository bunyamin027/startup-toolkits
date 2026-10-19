import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/engines/list_engine.dart';

void main() {
  const stages = ['To contact', 'Contacted', 'Meeting', 'Committed', 'Passed'];
  final items = [
    const ListItem(
      id: '1',
      title: 'Seed Fund',
      stage: 'Meeting',
      fields: {'amount': 250000},
    ),
    const ListItem(
      id: '2',
      title: 'Angel',
      stage: 'Committed',
      fields: {'amount': '50,000'},
    ),
    const ListItem(
      id: '3',
      title: 'VC',
      stage: 'Committed',
      fields: {'amount': 500000},
    ),
  ];

  test('advance moves to next stage and stops at the last', () {
    var list = ListEngine.advance(items, '1', stages);
    expect(list.first.stage, 'Committed');
    list = ListEngine.moveTo(list, '1', 'Passed');
    list = ListEngine.advance(list, '1', stages);
    expect(list.first.stage, 'Passed');
  });

  test('add, update, remove keep other items intact', () {
    var list = ListEngine.add(
      items,
      const ListItem(id: '4', title: 'New', stage: 'To contact'),
    );
    expect(list, hasLength(4));
    list = ListEngine.update(list, list.last.copyWith(title: 'Renamed'));
    expect(list.last.title, 'Renamed');
    list = ListEngine.remove(list, '2');
    expect(list.map((i) => i.id), ['1', '3', '4']);
  });

  test('counts and totals', () {
    expect(ListEngine.countByStage(items, stages), {
      'To contact': 0,
      'Contacted': 0,
      'Meeting': 1,
      'Committed': 2,
      'Passed': 0,
    });
    expect(ListEngine.total(items, 'amount'), 800000);
    expect(ListEngine.total(items, 'amount', stage: 'Committed'), 550000);
  });

  test('json round trip', () {
    final back = ListItem.fromJson(items.first.toJson());
    expect(back.toJson(), items.first.toJson());
  });
}
