import 'package:app/common_lib.dart';
import 'package:app/paging/paging_list_delegate.dart';
import 'package:app/utils/widgets/break_line.dart';
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
  });
  final PagingController<int, dynamic> pagingController;
  final void Function(T) onSelect;
  final String titleText;
  final void Function(String?)? onSearch;
  final TextEditingController? searchController;
  final Widget Function(T)? subtitleBuilder, leadingBuilder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Unfocus when tapping anywhere
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BorderSize.medium),
          topRight: Radius.circular(BorderSize.medium),
        ),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(Insets.medium),
              BreakLine(),
              const Gap(Insets.medium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
                child: Text(
                  titleText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              const Gap(Insets.medium),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.outline,
                      width: 0.5,
                    ),
                    color: context.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(BorderSize.medium),
                      topRight: Radius.circular(BorderSize.medium),
                    ),
                  ),
                  padding: Insets.mediumAll,
                  child: ColumnPadded(children: [
                    CustomTextFormField(
                      prefixIcon:
                          SvgPrefixIcon(svgPath: Assets.assetsSvgSearch01),
                      controller:
                          searchController ?? useTextEditingController(),
                      hintText: context.l10n.search,
                      onChanged: onSearch,
                    ),
                    Expanded(
                      child: PagedListView.separated(
                        pagingController: pagingController,
                        builderDelegate: defaultListPagedChildBuilderDelegate(
                          context: context,
                          controller: pagingController,
                          itemBuilder: (context, item, index) {
                            return ListTile(
                              title: Text(item?.name ?? ""),
                              subtitle: subtitleBuilder?.call(item as T),
                              leading: leadingBuilder?.call(item as T),
                              onTap: () => onSelect(item as T),
                            );
                          },
                        ),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 0.5,
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
