import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../common_lib.dart';

PagedChildBuilderDelegate<ItemType>
    defaultListPagedChildBuilderDelegate<ItemType>({
  required BuildContext context,
  required PagingController<int, ItemType> controller,
  required ItemWidgetBuilder<ItemType> itemBuilder,
  Widget Function(BuildContext)? firstPageProgressIndicatorBuilder,
  Widget Function(BuildContext)? noItemsFoundIndicatorBuilder,
  Widget Function(BuildContext)? firstPageErrorIndicatorBuilder,
  Widget Function(BuildContext)? newPageProgressIndicatorBuilder,
}) {
  final theme = Theme.of(context);

  return PagedChildBuilderDelegate<ItemType>(
    itemBuilder: itemBuilder,
    // animateTransitions wraps the listing in SliverAnimatedSwitcher and
    // briefly keeps a stale child mounted while the items list changes,
    // which triggers a RangeError when items shrink (e.g. on delete/dedup).
    // See Crashlytics 12fe9b17866374ab0dc5489015777d51.
    animateTransitions: false,
    transitionDuration: Time.small,
    firstPageErrorIndicatorBuilder: firstPageErrorIndicatorBuilder ??
        (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: Insets.medium,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_off_outlined,
                    size: 72,
                    color: theme.colorScheme.outline,
                  ),
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
        onTap: controller.fetchNextPage,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: Insets.medium,
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
    firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder ??
        (context) {
          return const Center(
            child: Padding(
              padding: Insets.mediumAll,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              ),
            ),
          );
        },
    newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder ??
        (context) {
          return const Center(
            child: Padding(
              padding: Insets.mediumAll,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              ),
            ),
          );
        },
    noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder ??
        (context) {
          return Padding(
            padding: Insets.mediumAll,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Insets.medium,
              children: [
                Lottie.asset('assets/lottie/empty.json', height: 240),
                Text(
                  context.l10n.noItemsFoundError,
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(
                  width: context.width,
                  child: FilledButton(
                    onPressed: controller.refresh,
                    child: Text(context.l10n.retry),
                  ),
                )
              ],
            ),
          );
        },
    noMoreItemsIndicatorBuilder: (context) {
      return const SizedBox.shrink();
    },
  );
}
