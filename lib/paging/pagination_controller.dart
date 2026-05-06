import 'dart:developer';

import 'package:app/data/models/paginated_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef PageChanged<T> = Future<PaginatedResponse<T>> Function(int pageKey);

class _PagingControllerHookCreator {
  const _PagingControllerHookCreator();

  PagingController<int, ItemType> call<ItemType>({
    int page = 1,
    int perPage = 15,
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
  late final PagingController<int, ItemType> _controller =
      PagingController<int, ItemType>(
    getNextPageKey: (state) {
      final lastPage = state.pages?.lastOrNull;
      if (lastPage != null && lastPage.length < hook.perPage) return null;
      return (state.keys?.lastOrNull ?? (hook.page - 1)) + 1;
    },
    fetchPage: (pageKey) async {
      try {
        final page = await hook.listen(pageKey);
        return page.items;
      } catch (error, stackTrace) {
        if (error.toString().contains('disposed')) return <ItemType>[];
        log('usePagingController error',
            error: error, stackTrace: stackTrace);
        rethrow;
      }
    },
  );

  @override
  PagingController<int, ItemType> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  String get debugLabel => 'usePagingController';
}

/// Backward-compatibility shims for the v4 API so that existing call sites
/// can continue to read `controller.itemList` / `controller.nextPageKey` and
/// reassign items in place.
extension PagingControllerBackCompat<ItemType>
    on PagingController<int, ItemType> {
  /// Flattened list of items (alias of v5 [items]).
  List<ItemType>? get itemList => value.items;

  /// Sets the items, preserving the original page shape when possible.
  ///
  /// If [newItems] length matches the current total, the items are distributed
  /// across the existing pages so that keys stay aligned. Otherwise the items
  /// collapse into a single page keyed by the last fetched key.
  set itemList(List<ItemType>? newItems) {
    final state = value;
    if (newItems == null) {
      value = state.reset();
      return;
    }
    final keys = state.keys;
    if (keys == null || keys.isEmpty) {
      value = state.copyWith(pages: [newItems], keys: const [1]);
      return;
    }
    final totalOld = state.items?.length ?? 0;
    if (totalOld == newItems.length && (state.pages?.isNotEmpty ?? false)) {
      final pages = <List<ItemType>>[];
      var idx = 0;
      for (final p in state.pages!) {
        pages.add(newItems.sublist(idx, idx + p.length));
        idx += p.length;
      }
      value = state.copyWith(pages: pages);
    } else {
      value = state.copyWith(pages: [newItems], keys: [keys.last]);
    }
  }

  /// The next page key assuming integer keys starting at 1.
  int get nextPageKey => (value.keys?.lastOrNull ?? 0) + 1;
}

/// Backward-compatibility shim for reading `state.itemList` (alias of [items]).
extension PagingStateBackCompat<ItemType> on PagingState<int, ItemType> {
  List<ItemType>? get itemList => items;
}
