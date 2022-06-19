/// 订阅者回调签名
typedef EventCallback = void Function(dynamic arg);

class EventBus {
  // Internal constructor.
  EventBus._internal();

  // The instance of this.
  static final EventBus _singleton = EventBus._internal();

  // Singleton factory constructor.
  factory EventBus() => _singleton;

  // Queue holding event subscribers.
  // key:event(id), value: subscribers queue.
  final _eMap = <Object, List<EventCallback>?>{};

  /// Add a subscriber.
  void on(eventName, EventCallback f) {
    _eMap[eventName] ??= <EventCallback>[];
    _eMap[eventName]!.add(f);
  }

  /// Remove a subscriber.
  void off(eventName, [EventCallback? f]) {
    var list = _eMap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _eMap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  /// Trigger an event.
  /// All subscribers of the event will be called after the event is triggered.
  void emit(eventName, [arg]) {
    var list = _eMap[eventName];
    if (list == null) return;
    var len = list.length - 1;
    // Reverse traversal to prevent subscribers from removing
    // their own subscript dislocations in the callback
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

/// Define a top-level (global) variable.
/// Can use bus directly after importing the file.
var bus = EventBus();
