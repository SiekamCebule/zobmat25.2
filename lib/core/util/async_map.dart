import 'dart:async';

extension AsyncMap<T> on Iterable<T> {
  Future<Iterable<E>> asyncMap<E>(Future<E> Function(T) callback) async {
    final futures = map((element) => callback(element));
    return Future.wait(futures);
  }
}
