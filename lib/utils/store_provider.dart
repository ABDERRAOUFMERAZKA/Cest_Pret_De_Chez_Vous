import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// A provider that exposes a [ValueNotifier] in two independent pieces.
///
/// [StoreProvider] will expose both [ValueNotifier] and [ValueNotifier.value] independently
/// to its dependents.
///
/// For the [ValueNotifier]:
///
/// ```dart
/// class MyStore extends ValueNotifier<int> {
///   MyStore(): super(0);
/// }
/// ```
///
/// it is possible to obtain the `MyStore` instance through:
///
/// ```dart
/// Provider.of<MyStore>(context);
/// ```
///
/// and the current value through:
///
/// ```dart
/// Provider.of<int>(context);
/// ```
class StoreProvider<Value, Controller extends ValueNotifier<Value>>
    extends ValueDelegateWidget<Controller>
    implements SingleChildCloneableWidget {
  /// Allows to specify parameters to [StoreProvider].
  StoreProvider({
    Key key,
    @required ValueBuilder<Controller> builder,
    Widget child,
  }) : this._(
          key: key,
          delegate: BuilderStateDelegate<Controller>(builder,
              dispose: (_, v) => v.dispose()),
          updateShouldNotify: null,
          child: child,
        );

  /// Allows to specify parameters to [StoreProvider].
  StoreProvider.value({
    Key key,
    @required Controller value,
    UpdateShouldNotify<Controller> updateShouldNotify,
    Widget child,
  }) : this._(
          key: key,
          delegate: SingleValueDelegate<Controller>(value),
          updateShouldNotify: updateShouldNotify,
          child: child,
        );

  StoreProvider._({
    Key key,
    @required ValueStateDelegate<Controller> delegate,
    this.updateShouldNotify,
    this.child,
  }) : super(key: key, delegate: delegate);

  /// User-provided custom logic for [InheritedWidget.updateShouldNotify].
  final UpdateShouldNotify<Controller> updateShouldNotify;

  @override
  StoreProvider<Value, Controller> cloneWithChild(Widget child) {
    return StoreProvider._(
      key: key,
      delegate: delegate,
      updateShouldNotify: updateShouldNotify,
      child: child,
    );
  }

  /// The widget that is below the current [StoreProvider] widget in the
  /// tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    assert(() {
      Provider.debugCheckInvalidValueType?.call<Controller>(delegate.value);
      return true;
    }());
    return InheritedProvider<Controller>(
      value: delegate.value,
      updateShouldNotify: updateShouldNotify,
      child: ValueListenableProvider<Value>.value(
        value: delegate.value,
        child: child,
      ),
    );
  }
}
