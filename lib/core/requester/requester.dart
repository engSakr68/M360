import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member360/core/errors/base_error.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/requester/state/requester_state.dart';

abstract class Requester<T> extends Cubit<RequesterState<T>> {
  Requester({RequesterState<T>? initialState})
      : super(initialState ?? const RequesterState.init());

  Future<void> request({bool fromRemote = true});

  /// PLEASE DON'T use these protected method outside subclasses

  @override
  @protected
  void emit(RequesterState<T> state) {
    super.emit(state);
  }

  @protected
  void successState(T data, [bool isLoading = false]) {
    emit(RequesterState.success(data, isLoading));
  }

  @protected
  void failedState(BaseError error, VoidCallback callback) {
    emit(RequesterState.failure(error, callback));
  }

  @protected
  void loadingState() {
    emit(const RequesterState.loading());
  }

  /// This method will wait result and wait loading to finish
  @nonVirtual
  Future<void> waitIfLoading() async {
    await Future.delayed(const Duration(milliseconds: 20));
    if (isLoading) {
      await stream.firstWhere((element) {
        return element.whenOrNull(loading: () => false) ?? true;
      });
    }
  }

  /// This method will request if no data and wait if loading
  /// DO NOT use the result in the general case
  /// DO NOT use the result in the general case
  /// DO NOT use the result in the general case
  @nonVirtual
  Future<MyResult<T>> requestIfNoDataAndWaitIfLoading(
      {bool fromRemote = true}) async {
    if (hasNoData && !isLoading) {
      request(fromRemote: fromRemote);
    }
    await waitIfLoading();
    return state.maybeWhen(
      success: (data, isLoading) => MyResult.isSuccess(data),
      failure: (error, callback) => MyResult.isError(error),
      orElse: () => MyResult.isError(BaseError.unknown()),
    );
  }

  T? get data => state.whenOrNull(success: (data, isLoading) => data);

  BaseError? get error => state.whenOrNull(failure: (error, callback) => error);

  bool get hasData => data != null;

  bool get hasError => error != null;

  bool get hasNoData => data == null;

  bool get isSuccess => state.whenOrNull(success: (_, __) => true) ?? false;

  bool get isFail =>
      (state.whenOrNull(failure: (error, callback) => true) ?? false);

  bool get isLoading => (state.whenOrNull(loading: () => true) ?? false);
}
