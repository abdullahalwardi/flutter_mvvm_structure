// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:app/common_lib.dart';
// import 'package:app/src/location/current_location_card.dart';
// import 'package:app/src/location/pick_location_page.dart';

// class PickLocationCard extends StatelessWidget {
//   const PickLocationCard({
//     super.key,
//     required this.pickedLocationNotifier,
//     this.initialLocation,
//   });

//   final ValueNotifier<LatLng?> pickedLocationNotifier;
//   final LatLng? initialLocation;

//   @override
//   Widget build(BuildContext context) {
//     return ColumnPadded(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               context.l10n.pickLocation,
//               style: Theme.of(context).textTheme.titleSmall,
//             ),
//             TextButton.icon(
//               onPressed: ()async {
//                   await showDialog(
//                     context: context,
//                     builder: (context) => Dialog.fullscreen(
//                       child: PickLocationPage(
//                         onLocationChanged: (value) {
//                           pickedLocationNotifier.value = value;
//                         },
//                         onBackPressed: context.pop,
//                         onSelectPressed: context.pop,
//                       ),
//                     ),
//                   );
//                 },
//               icon: Icon(
//                 Icons.location_on_outlined,
//                 color: context.colorScheme.tertiary,
//               ),
//               label: Text(
//                 context.l10n.relocate,
//                 style: TextStyle(
//                     color: context.colorScheme.tertiary, fontSize: 14),
//               ),
//               style: TextButton.styleFrom(
//                 padding: Insets.smallAll,
//               ),
//             ),
//           ],
//         ),
//         InkWell(
//           onTap: ()async {
//                   await showDialog(
//                     context: context,
//                     builder: (context) => Dialog.fullscreen(
//                       child: PickLocationPage(
//                         onLocationChanged: (value) {
//                           pickedLocationNotifier.value = value;
//                         },
//                         onBackPressed: context.pop,
//                         onSelectPressed: context.pop,
//                       ),
//                     ),
//                   );
//                 },
//           borderRadius: BorderSize.extraSmallRadius,
//           child: Container(
//               height: 200,
//               width: context.width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderSize.extraSmallRadius,
//                 border: Border.all(color: Theme.of(context).dividerColor),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderSize.extraSmallRadius,
//                 child: CurrentLocationCard(
//                   initialLocation: initialLocation,
//                 ),
//               )
//               ),
//         ),
//       ],
//     );
//   }
// }
