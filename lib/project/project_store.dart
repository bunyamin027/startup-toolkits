import '../core/storage/key_value_store.dart';
import 'project.dart';

class ProjectStore {
  ProjectStore(this._kv);

  static const _key = 'project.v1';

  final KeyValueStore _kv;

  Future<Project> load() async {
    final json = await _kv.readJson(_key);
    return json is Map<String, Object?>
        ? Project.fromJson(json)
        : const Project();
  }

  Future<void> save(Project project) => _kv.writeJson(_key, project.toJson());
}
