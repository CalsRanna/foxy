import 'dart:async';

/// 标准事件总线：发布/订阅式的跨模块通信。
///
/// 生产者通过 [fire] 发布事件，消费者通过 [on] 订阅指定类型的事件。
/// 内部为 broadcast 流，同一事件类型可被多个消费者同时订阅。
///
/// 典型用法：
///
/// ```dart
/// final bus = GetIt.instance.get<EventBus>();
/// final sub = bus.on<ActivityLoggedEvent>().listen((e) => handle(e.log));
/// bus.fire(ActivityLoggedEvent(log)); // 任意位置发布
/// sub.cancel(); // 消费者销毁时取消订阅
/// ```
class EventBus {
  EventBus({bool sync = false})
    : _controller = StreamController<dynamic>.broadcast(sync: sync);

  final StreamController<dynamic> _controller;

  /// 返回类型为 [T] 的事件流。
  Stream<T> on<T>() =>
      _controller.stream.where((event) => event is T).cast<T>();

  /// 发布一个事件，所有订阅该事件类型的监听者都会收到。
  void fire<T>(T event) => _controller.add(event);

  /// 关闭总线（通常仅应用退出时调用）。
  void destroy() => _controller.close();
}
