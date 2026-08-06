import 'dart:async';

/// Standard event bus: publish/subscribe cross-module communication.
///
/// Producers publish via [fire]; consumers subscribe to a given event type
/// via [on]. Internally a broadcast stream, so multiple consumers can
/// subscribe to the same event type concurrently.
///
/// Typical usage:
///
/// ```dart
/// final bus = GetIt.instance.get<EventBus>();
/// final sub = bus.on<ActivityLoggedEvent>().listen((e) => handle(e.log));
/// bus.fire(ActivityLoggedEvent(log)); // publish from anywhere
/// sub.cancel(); // cancel subscription when the consumer is destroyed
/// ```
class EventBus {
  final StreamController<dynamic> _controller;

  EventBus({bool sync = false})
    : _controller = StreamController<dynamic>.broadcast(sync: sync);

  /// Shuts the bus down (usually only called on app exit).
  void destroy() => _controller.close();

  /// Publishes an event; every listener subscribed to that event type
  /// receives it.
  void fire<T>(T event) => _controller.add(event);

  /// Returns the stream of events of type [T].
  Stream<T> on<T>() =>
      _controller.stream.where((event) => event is T).cast<T>();
}
