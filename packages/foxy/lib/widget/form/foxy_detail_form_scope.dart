import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// Wires a detail form into the global save shortcut (`Cmd/Ctrl+S`) and the
/// router's unsaved-changes leave guard.
///
/// Tracks [loading] and [submitting] transitions on [viewModel] so
/// `FieldControllerMixin.markClean` is refreshed after each successful load
/// or save without touching generated view-model code.
class FoxyDetailFormScope extends StatefulWidget {
  static final _scopes = <_FoxyDetailFormScopeState>[];

  final FieldControllerMixin viewModel;
  final ReadonlySignal<bool> loading;
  final ReadonlySignal<bool> submitting;
  final ReadonlySignal<String?> errorMessage;
  final Future<void> Function() onSave;
  final Widget child;

  const FoxyDetailFormScope({
    super.key,
    required this.viewModel,
    required this.loading,
    required this.submitting,
    required this.errorMessage,
    required this.onSave,
    required this.child,
  });

  @override
  State<FoxyDetailFormScope> createState() => _FoxyDetailFormScopeState();

  /// Triggers [onSave] on the currently visible detail form on the top route.
  ///
  /// Returns `true` when an eligible visible form was found (even if it is
  /// currently busy loading or submitting).
  static bool saveActive() {
    for (var i = _scopes.length - 1; i >= 0; i--) {
      final scope = _scopes[i];
      if (!scope.mounted || !scope._isVisible) continue;
      if (!scope.widget.loading.peek() && !scope.widget.submitting.peek()) {
        unawaited(scope.widget.onSave());
      }
      return true;
    }
    return false;
  }
}

class _FoxyDetailFormScopeState extends State<FoxyDetailFormScope> {
  VoidCallback? _unregisterDirtyCheck;
  void Function()? _unsubscribeLoading;
  void Function()? _unsubscribeSubmitting;
  bool _wasLoading = false;
  bool _wasSubmitting = false;

  bool get _isVisible {
    if (ModalRoute.of(context)?.isCurrent != true) return false;
    var hidden = false;
    context.visitAncestorElements((element) {
      final ancestor = element.widget;
      if (ancestor is Offstage && ancestor.offstage) {
        hidden = true;
        return false;
      }
      return true;
    });
    return !hidden;
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void didUpdateWidget(covariant FoxyDetailFormScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != widget.viewModel ||
        oldWidget.loading != widget.loading ||
        oldWidget.submitting != widget.submitting) {
      _unsubscribeSignals();
      _subscribeSignals();
    }
  }

  @override
  void dispose() {
    FoxyDetailFormScope._scopes.remove(this);
    _unregisterDirtyCheck?.call();
    _unsubscribeSignals();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FoxyDetailFormScope._scopes.add(this);
    if (GetIt.instance.isRegistered<RouterFacade>()) {
      _unregisterDirtyCheck = GetIt.instance
          .get<RouterFacade>()
          .registerDirtyCheck(() => widget.viewModel.hasUnsavedChanges);
    }
    _subscribeSignals();
  }

  void _subscribeSignals() {
    _wasLoading = widget.loading.peek();
    _wasSubmitting = widget.submitting.peek();
    if (!_wasLoading && widget.errorMessage.peek() == null) {
      widget.viewModel.markClean();
    }
    _unsubscribeLoading = widget.loading.subscribe((isLoading) {
      if (_wasLoading && !isLoading && widget.errorMessage.peek() == null) {
        widget.viewModel.markClean();
      }
      _wasLoading = isLoading;
    });
    _unsubscribeSubmitting = widget.submitting.subscribe((isSubmitting) {
      if (_wasSubmitting &&
          !isSubmitting &&
          widget.errorMessage.peek() == null) {
        widget.viewModel.markClean();
      }
      _wasSubmitting = isSubmitting;
    });
  }

  void _unsubscribeSignals() {
    _unsubscribeLoading?.call();
    _unsubscribeLoading = null;
    _unsubscribeSubmitting?.call();
    _unsubscribeSubmitting = null;
  }
}
