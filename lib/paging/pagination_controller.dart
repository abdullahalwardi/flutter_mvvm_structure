import 'dart:developer';

import 'package:app/data/models/_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef PageChanged<T> = Future<PaginatedResponse<T>> Function(int pageKey);

class _PagingControllerHookCreator {
  const _PagingControllerHookCreator();

  PagingController<int, ItemType> call<ItemType>({
    int page = 1,
    int perPage = 25,
    required PageChanged<ItemType> listen,
    List<Object?>? keys,
  }) {
    return use(_PagingControllerHook<ItemType>(page, perPage, listen, keys));
  }
}

const usePagingController = _PagingControllerHookCreator();

class _PagingControllerHook<ItemType>
    extends Hook<PagingController<int, ItemType>> {
  const _PagingControllerHook(
    this.page,
    this.perPage,
    this.listen, [
    List<Object?>? keys,
  ]) : super(keys: keys);

  final int page;
  final int perPage;
  final PageChanged<ItemType> listen;

  @override
  _PagingControllerHookState<ItemType> createState() {
    return _PagingControllerHookState<ItemType>();
  }
}

class _PagingControllerHookState<ItemType> extends HookState<
    PagingController<int, ItemType>, _PagingControllerHook<ItemType>> {
  late final _controller =
      PagingController<int, ItemType>(firstPageKey: hook.page)
        ..listen(callback: hook.listen, perPage: hook.perPage);

  @override
  PagingController<int, ItemType> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  String get debugLabel => 'usePagingController';
}

extension PagingControllerX<ItemType> on PagingController<int, ItemType> {
  void listen({required PageChanged<ItemType> callback, required int perPage}) {
    addPageRequestListener((int pageKey) async {
      try {
        final page = await callback(pageKey);

        final isLastPage = page.result.length < perPage;
        if (isLastPage) {
          appendLastPage(page.result);
        } else {
          final nextPageKey = pageKey + 1;
          appendPage(page.result, nextPageKey);
        }
      } catch (e, stackTrace) {
        log(toString(), error: error, stackTrace: stackTrace);
        error = e;
      }
    });
  }
}
