// import 'package:flutter/widgets.dart';
// import 'package:app/common_lib.dart';
// import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

// class PaginatedSearchableDropdown extends StatelessWidget {
//   const PaginatedSearchableDropdown(
//       {super.key, required this.paginatedRequest, required this.onChanged});

//   final Future<List<SearchableDropdownMenuItem<int>>?> Function(int, String?)?
//       paginatedRequest;
//   final void Function(int?)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: context.width,
//       // height: 60,
//       padding: const EdgeInsets.symmetric(
//         horizontal: Insets.medium,
//         vertical: Insets.small,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(BorderSize.extraSmall),
//         border: Border.all(
//           color: context.colorScheme.outline.withOpacity(0.5),
//           width: 1,
//         ),
//         color: context.colorScheme.surfaceContainerHighest.withOpacity(0.5),
//       ),
//       child: SearchableDropdown<int>.paginated(
//         hintText: const Text('نوع السيارة'),
//         requestItemCount: 25,
//         paginatedRequest: paginatedRequest,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
