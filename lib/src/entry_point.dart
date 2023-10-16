// import 'package:app/common_lib.dart';
// import 'package:flutter/material.dart';

// class EntryPoint extends StatefulHookConsumerWidget {
//   const EntryPoint({super.key, required this.child});

//   final Widget child;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _EntryPointState();
// }

// class _EntryPointState extends ConsumerState<EntryPoint> {
//   @override
//   Widget build(BuildContext context) {
//     final pages = [
//       RoutesDocument.home,
//       RoutesDocument.categories,
//       RoutesDocument.bookMark,
//       RoutesDocument.profile,
//     ];
//     int getSelectedIndex() {
//       final String location = GoRouterState.of(context).fullPath!;

//       return pages.indexOf(location);
//     }

//     void onItemTapped(int index) {
//       GoRouter.of(context).go(pages[index]);
//     }

//     return Scaffold(
//       body: widget.child,
//       bottomNavigationBar: NavigationBar(
//         animationDuration: Time.small,
//         selectedIndex: getSelectedIndex(),
//         destinations: const [
//           NavigationDestination(
//             icon: Icon(Icons.home),
//             label: 'الرئيسية',
//             tooltip: 'الرئيسية',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.category),
//             label: 'الاقسام',
//             tooltip: 'الاقسام',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.bookmark),
//             label: 'المحفوظات',
//             tooltip: 'المحفوظات',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.person),
//             label: 'الملف الشخصي',
//             tooltip: 'الملف الشخصي',
//           ),
//         ],
//         onDestinationSelected: onItemTapped,
//         labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//       ),
//     );
//   }
// }
