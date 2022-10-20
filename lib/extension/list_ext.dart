import '../common/pair.dart';

extension ListExt<E> on List<E> {
  E? firstOrNull() => isNotEmpty ? first : null;
}

extension IterableExt<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? find(bool Function(T element) predicate) {
    final list = where(predicate);
    return list.isEmpty ? null : list.first;
  }

  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) => fold(
      <K, List<T>>{},
      (Map<K, List<T>> map, T element) =>
          map..putIfAbsent(keyFunction(element), () => <T>[]).add(element));

  T? maxByOrNull(num Function(T element) value) {
    if (isEmpty) return null;
    T maxItem = first;
    num maxValue = value(maxItem);
    forEach((element) {
      final elementValue = value(element);
      if (elementValue > maxValue) {
        maxItem = element;
        maxValue = elementValue;
      }
    });
    return maxItem;
  }

  num? maxOfOrNull(num Function(T element) value) {
    if (isEmpty) return null;
    T maxItem = first;
    num maxValue = value(maxItem);
    forEach((element) {
      final elementValue = value(element);
      if (elementValue > maxValue) {
        maxItem = element;
        maxValue = elementValue;
      }
    });
    return maxValue;
  }
}

extension MapX<K, V> on Map<K, V> {
  List<Pair<K, V>> toList() {
    List<Pair<K, V>> list = [];
    for (var key in keys) {
      final value = this[key];
      if (value != null) list.add(Pair(key, value));
    }
    return list;
  }
}
