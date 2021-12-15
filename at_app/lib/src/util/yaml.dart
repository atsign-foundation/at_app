import 'package:yaml/yaml.dart';

extension YamlMapParser<K, V> on YamlMap {
  Map<K, V> toMap() {
    Map<K, V> result = {};
    forEach((key, value) {
      result[key] = value;
    });
    return result;
  }
}
