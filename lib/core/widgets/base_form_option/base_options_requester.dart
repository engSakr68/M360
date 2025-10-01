import 'dart:async';

import 'package:member360/core/extensions/string_helper_extension.dart';
import 'package:member360/core/http/models/result.dart';
import 'package:member360/core/requester/requester.dart';

class BaseOptionsRequester<T> extends Requester<List<T>> {
  final Future<MyResult<List<T>>> Function(String? searchTerm) fetcher;
  final bool immediatelyRequestOptions;
  final String? Function(T?) valueMainTitleGetter;
  final bool isRemotelySearch;
  List<T>? _initialOptions;
  String? _searchTerm;
  Timer? _requestDebounceTimer;

  BaseOptionsRequester(
      {required this.isRemotelySearch,
      required this.immediatelyRequestOptions,
      required this.valueMainTitleGetter,
      required this.fetcher}) {
    if (immediatelyRequestOptions) {
      request();
    }
  }

  void emitLastData() {
    successState(data ?? []);
  }

  Future<List<T>> get options async {
    await requestIfNoDataAndWaitIfLoading();
    return _initialOptions!;
  }

  Future<void> search(String? searchTerm) async {
    if (_initialOptions != null) {
      if (isRemotelySearch) {
        _searchRemotely(searchTerm);
      } else {
        _searchLocally(searchTerm);
      }
    }
  }

  void _searchRemotely(String? searchTerm) {
    if (_requestDebounceTimer != null && _requestDebounceTimer!.isActive) {
      _requestDebounceTimer!.cancel();
    }
    if (searchTerm.isBlank) {
      _searchTerm = null;
      successState(_initialOptions!);
    } else {
      _searchTerm = searchTerm;
      _requestDebounceTimer = Timer(const Duration(milliseconds: 600), () {
        loadingState();
        request();
      });
    }
  }

  void _searchLocally(String? searchTerm) {
    if (searchTerm.isBlank) {
      successState(_initialOptions!);
      return;
    }
    List<T> searchedEntries = [];
    for (var element in _initialOptions!) {
      if (valueMainTitleGetter(element)
              ?.toLowerCase()
              .contains(searchTerm!.toLowerCase()) ??
          false) {
        searchedEntries.add(element);
      }
    }
    successState(searchedEntries);
  }

  void addOptionLocally(T option) {
    _initialOptions?.insert(0, option);
    successState(_initialOptions ?? []);
  }

  @override
  Future<void> request({bool fromRemote = true}) async {
    if (hasNoData) loadingState();
    final result = await fetcher(_searchTerm);
    result.when(isSuccess: (items) {
      _initialOptions ??= items ?? [];
      successState(items ?? []);
    }, isError: (error) {
      failedState(error, request);
    });
  }
}
