import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/engines/list_engine.dart';
import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/project/project_store.dart';
import 'package:startup_toolkits/tools/tool_def.dart';
import 'package:startup_toolkits/tools/tool_stores.dart';

void main() {
  late KeyValueStore kv;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    kv = PrefsKeyValueStore();
  });

  test('project survives save and load', () async {
    final store = ProjectStore(kv);
    expect((await store.load()).filledCount, 0);

    final project = const Project()
        .withValue(ProjectField.startupName, 'Rocketly')
        .withValue(ProjectField.cash, '120000')
        .withGoal(Goal.raiseFunding);
    await store.save(project);

    final loaded = await ProjectStore(kv).load();
    expect(loaded[ProjectField.startupName], 'Rocketly');
    expect(loaded[ProjectField.cash], '120000');
    expect(loaded.goal, Goal.raiseFunding);
  });

  test('corrupt data falls back to an empty project', () async {
    await kv.write('project.v1', '{not json');
    expect((await ProjectStore(kv).load()).filledCount, 0);
  });

  test('favorites toggle', () async {
    final store = FavoritesStore(kv);
    expect(await store.toggle('runway'), {'runway'});
    expect(await store.toggle('swot'), {'runway', 'swot'});
    expect(await store.toggle('runway'), {'swot'});
    expect(await FavoritesStore(kv).load(), {'swot'});
  });

  test('list items per tool; unsaved tool returns null', () async {
    final store = ListStore(kv);
    expect(await store.load('crm'), isNull);
    await store.save('crm', [
      const ListItem(
        id: '1',
        title: 'Acme',
        stage: 'Lead',
        fields: {'value': 900},
      ),
    ]);
    final items = await ListStore(kv).load('crm');
    expect(items!.single.title, 'Acme');
    expect(items.single.fields['value'], 900);
    expect(await store.load('kanban'), isNull);
  });
}
