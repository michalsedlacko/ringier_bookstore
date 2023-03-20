import 'dart:async';
import 'dart:math';

String getRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

class Debouncer<T> {
  final Duration duration;
  void Function(T value) onValue;
  late T _value;
  Timer? _timer;

  Debouncer(this.duration, this.onValue);

  T get value => _value;
  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}
