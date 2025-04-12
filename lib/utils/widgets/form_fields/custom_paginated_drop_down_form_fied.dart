import 'package:app/common_lib.dart';
import 'package:app/utils/widgets/paginated_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPaginatedDropdownFormField<T> extends HookConsumerWidget {
  const CustomPaginatedDropdownFormField({
    super.key,
    required this.pagingController,
    required this.hintText,
    required this.valueNotifier,
    this.labelText,
    this.onSelect,
    this.onSearch,
    this.searchController,
    this.prefixIcon,
    this.validator,
    this.subtitleBuilder,
    this.leadingBuilder,
  });
  final PagingController<int, dynamic> pagingController;
  final String hintText;
  final String? labelText;
  final ValueNotifier valueNotifier;
  final void Function(T)? onSelect;
  final void Function(String?)? onSearch;
  final TextEditingController? searchController;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget Function(T)? subtitleBuilder, leadingBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController =
        useTextEditingController(text: valueNotifier.value?.name);
    valueNotifier.addListener(() {
      textEditingController.text = valueNotifier.value?.name ?? '';
    });
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return CustomTextFormField(
            prefixIcon: prefixIcon,
            controller: textEditingController,
            hintText: hintText,
            labelText: labelText,
            suffixIcon: value == null
                ? null
                : IconButton(
                    onPressed: () {
                      textEditingController.clear();
                      valueNotifier.value = null;
                    },
                    icon: Icon(Icons.close)),
            validator: validator,
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return PaginatedBottomSheet<T>(
                    titleText:
                        "${context.l10n.select} ${labelText ?? hintText}",
                    pagingController: pagingController,
                    searchController: searchController,
                    onSearch: onSearch,
                    onSelect: (value) {
                      final dynamicValue = value as dynamic;
                      valueNotifier.value = value;

                      textEditingController.text = dynamicValue.name;

                      if (onSelect != null) {
                        onSelect!(value);
                      }
                      GoRouter.of(context).pop();
                    },
                    subtitleBuilder: subtitleBuilder,
                    leadingBuilder: leadingBuilder,
                  );
                },
              );
            },
            readOnly: true,
          );
        });
  }
}
