import 'dart:async';

import 'package:rxdart/src/utils/collection_extensions.dart';
import 'package:rxdart/src/utils/subscription.dart';

/// From: https://stackoverflow.com/a/71482535/9290771
class CombineAnyLatestStream<T, R> extends StreamView<R> {
  CombineAnyLatestStream(List<Stream<T>> streams, R Function(List<T?>) combiner)
      : super(_buildController(streams, combiner).stream);

  static StreamController<R> _buildController<T, R>(
    Iterable<Stream<T>> streams,
    R Function(List<T?> values) combiner,
  ) {
    int completed = 0;

    late List<StreamSubscription<T>> subscriptions;
    List<T?>? values;

    final controller = StreamController<R>(sync: true);

    controller.onListen = () {
      void onDone() {
        if (++completed == streams.length) {
          controller.close();
        }
      }

      subscriptions = streams.mapIndexed((index, stream) {
        return stream.listen((T event) {
          final R combined;

          if (values == null) return;

          values![index] = event;

          try {
            combined = combiner(List<T?>.unmodifiable(values!));
          } catch (e, s) {
            controller.addError(e, s);
            return;
          }

          controller.add(combined);
        }, onError: controller.addError, onDone: onDone);
      }).toList(growable: false);

      if (subscriptions.isEmpty) {
        controller.close();
      } else {
        values = List<T?>.filled(subscriptions.length, null);
      }
    };

    controller.onPause = () => subscriptions.pauseAll();
    controller.onResume = () => subscriptions.resumeAll();
    controller.onCancel = () {
      values = null;
      return subscriptions.cancelAll();
    };

    return controller;
  }
}
