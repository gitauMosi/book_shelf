import 'package:hive_flutter/hive_flutter.dart';

class DbClient {
  static final DbClient _instance = DbClient._internal();
  factory DbClient() => _instance;

  DbClient._internal();

  static const String _defaultBoxName = 'appBox';

  Box<dynamic>? _box;

  bool get isInitialized => _box != null;

  /// Register a single adapter safely
  void registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter<T>(adapter);
    }
  }

  /// Register multiple adapters (optional convenience)
  void registerAdapters(List<TypeAdapter> adapters) {
    for (final adapter in adapters) {
      if (!Hive.isAdapterRegistered(adapter.typeId)) {
        Hive.registerAdapter(adapter);
      }
    }
  }

  Future<void> init({
    String boxName = _defaultBoxName,
    List<TypeAdapter>? adapters,
  }) async {
    if (_box != null) return; // lazy + idempotent

    await Hive.initFlutter();

    // Register adapters before opening box
    if (adapters != null) {
      registerAdapters(adapters);
    }

    _box = await Hive.openBox(boxName);
  }

  Box<dynamic> get _safeBox {
    if (_box == null) {
      throw Exception(
        'DbClient not initialized. Call DbClient().init() first.',
      );
    }
    return _box!;
  }

  // ───────── String ─────────
  Future<void> addString({
    required String key,
    required String value,
  }) async {
    await _safeBox.put(key, value);
  }

  String getString({
    required String key,
    String defaultValue = '',
  }) {
    return _safeBox.get(key, defaultValue: defaultValue);
  }

  // ───────── List ─────────
  Future<void> addList({
    required String key,
    required List<dynamic> value,
  }) async {
    await _safeBox.put(key, value);
  }

  List<dynamic> getList({
    required String key,
    List<dynamic> defaultValue = const [],
  }) {
    return _safeBox.get(key, defaultValue: defaultValue);
  }

  // ───────── Dynamic ─────────
  Future<void> add({
    required String key,
    required dynamic value,
  }) async {
    await _safeBox.put(key, value);
  }

  dynamic get({
    required String key,
    dynamic defaultValue,
  }) {
    return _safeBox.get(key, defaultValue: defaultValue);
  }

  // ───────── Utilities ─────────
  Future<void> remove(String key) async {
    await _safeBox.delete(key);
  }

  Future<void> clear() async {
    await _safeBox.clear();
  }
}
