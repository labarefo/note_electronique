
import 'dart:async';

class AbstractDataDriver<T> {
  final _streamController = StreamController<T>();

  Stream<T> get stream => _streamController.stream;

  void send(T data) => _streamController.sink.add(data);

  void close() {
    _streamController.close();
  }
}