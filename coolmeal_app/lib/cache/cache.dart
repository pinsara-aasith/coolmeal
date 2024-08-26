import 'dart:async';

class CacheClient {
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  final _cacheUpdatesController =
      StreamController<Map<String, Object>>.broadcast();

  /// Stream of cache updates, emitted whenever the cache is modified.
  Stream<Map<String, Object>> get cacheUpdates =>
      _cacheUpdatesController.stream;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String key, required T value}) {
    if (_cache[key] == value)  {
      return;
     }
    
    _cache[key] = value;
    _cacheUpdatesController.add(_cache);
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;

    return null;
  }

  /// dispose the internal stream controller
  void dispose() {
    _cacheUpdatesController.close();
  }
}