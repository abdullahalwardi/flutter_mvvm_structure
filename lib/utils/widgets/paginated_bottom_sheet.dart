import 'package:app/common_lib.dart';
import 'package:app/paging/paging_list_delegate.dart';
import 'package:app/utils/widgets/bottom_sheets/bottom_sheet_header.dart';
import 'package:app/utils/widgets/svg_prefix_icon.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedBottomSheet<T> extends HookConsumerWidget {
  const PaginatedBottomSheet({
    super.key,
    required this.pagingController,
    required this.onSelect,
    required this.titleText,
    this.onSearch,
    this.searchController,
    this.subtitleBuilder,
    this.leadingBuilder,
    this.onFieldSubmitted,
    this.customItems,
  });
  final PagingController<int, dynamic> pagingController;
  final void Function(T) onSelect;
  final String titleText;
  final void Function(String?)? onSearch;
  final TextEditingController? searchController;
  final Widget Function(T)? subtitleBuilder, leadingBuilder;
  final List<Widget>? customItems;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useListenable(pagingController);
    final fieldController =
        searchController ?? useTextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(BorderSize.medium),
          topRight: Radius.circular(BorderSize.medium),
        ),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: context.colorScheme.surfaceContainerLowest,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeader(title: titleText),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Insets.medium),
                  child: Column(
                    spacing: Insets.medium,
                    children: [
                      CustomTextFormField(
                        prefixIcon:
                            SvgPrefixIcon(svgPath: Assets.assetsSvgSearch01),
                        controller: fieldController,
                        hintText: context.l10n.search,
                        onChanged: onSearch,
                        onFieldSubmitted: onFieldSubmitted,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await Future.sync(() => pagingController.refresh());
                          },
                          child: Column(
                            children: [
                              ...?customItems,
                              if (customItems != null)
                                const Divider(thickness: 0.5),
                              Expanded(
                                child: PagedListView.separated(
                                  state: pagingController.value,
                                  fetchNextPage: pagingController.fetchNextPage,
                                  builderDelegate:
                                      defaultListPagedChildBuilderDelegate(
                                    context: context,
                                    controller: pagingController,
                                    itemBuilder: (context, item, index) {
                                      return ListTile(
                                        title: Text(item?.name ?? ''),
                                        subtitle: subtitleBuilder
                                            ?.call(item as T),
                                        leading:
                                            leadingBuilder?.call(item as T),
                                        onTap: () => onSelect(item as T),
                                      );
                                    },
                                  ),
                                  separatorBuilder: (context, index) {
                                    return const Divider(thickness: 0.5);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
