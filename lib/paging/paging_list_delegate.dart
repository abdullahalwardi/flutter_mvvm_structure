import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../common_lib.dart';

PagedChildBuilderDelegate<ItemType>
    defaultListPagedChildBuilderDelegate<ItemType>({
  required BuildContext context,
  required PagingController<int, ItemType> controller,
  required ItemWidgetBuilder<ItemType> itemBuilder,
}) {
  final theme = Theme.of(context);

  return PagedChildBuilderDelegate<ItemType>(
    itemBuilder: itemBuilder,
    animateTransitions: true,
    transitionDuration: Time.small,
    firstPageErrorIndicatorBuilder: (context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ColumnPadded(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.defaultErrorMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              FilledButton(
                onPressed: controller.refresh,
                child: Text(context.l10n.retry),
              )
            ],
          ),
        ),
      );
    },
    newPageErrorIndicatorBuilder: (context) {
      return InkWell(
        onTap: () {
          controller.retryLastFailedRequest();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ColumnPadded(
            children: [
              Text(
                context.l10n.defaultErrorMessage,
                textAlign: TextAlign.center,
              ),
              const Icon(Icons.refresh),
            ],
          ),
        ),
      );
    },
    firstPageProgressIndicatorBuilder: (context) {
      return const Center(
        child: Padding(
          padding: Insets.mediumAll,
          child: CircularProgressIndicator(),
        ),
      );
    },
    newPageProgressIndicatorBuilder: (context) {
      return const Center(
        child: Padding(
          padding: Insets.mediumAll,
          child: CircularProgressIndicator(),
        ),
      );
    },
    noItemsFoundIndicatorBuilder: (context) {
      return ColumnPadded(
        children: [
          Text(
            context.l10n.noItemsFoundError,
            style: theme.textTheme.titleLarge,
          ),
          // todo: Add image or change filter button
          FilledButton(
            onPressed: controller.refresh,
            child: Text(context.l10n.retry),
          )
        ],
      );
    },
    noMoreItemsIndicatorBuilder: (context) {
      return const SizedBox.shrink();
    },
  );
}
