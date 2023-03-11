
import 'package:app/data/client/services/callback.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

Future<void> fetchPage<T>(
  {
  int? pageKey,
  required PagingController<int, T> pagingController,
  required FuturePaginatedResponse<T> futureItems,
  String? pageSize,
  }
) async {
  try {
    final newItems = await futureItems;
    final items = newItems.data.result;
    final isLastPage = items.length < int.parse(pageSize ?? "25");
    
    if (isLastPage) {
      pagingController.appendLastPage(items);
    } else {
      final nextPageKey = pageKey ?? 0 + items.length;
      pagingController.appendPage(items, nextPageKey);
    }
  } catch (error) {
    pagingController.error = error;
  }
}