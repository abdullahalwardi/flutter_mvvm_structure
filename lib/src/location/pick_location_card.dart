// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:elixir/common_lib.dart';
// import 'package:elixir/src/location/current_location_card.dart';
// import 'package:elixir/src/location/pick_location_page.dart';

// class PickLocationCard extends StatefulHookConsumerWidget {
//   const PickLocationCard({
//     super.key,
//     required this.pickedLocationNotifier,
//   });

//   final ValueNotifier<LatLng?> pickedLocationNotifier;

//   @override
//   ConsumerState<PickLocationCard> createState() => _PickLocationCardState();
// }

// class _PickLocationCardState extends ConsumerState<PickLocationCard> {
// @override
//   Widget build(BuildContext context) {
//     return ColumnPadded(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       gap: Insets.extraSmall,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               context.l10n.pickLocation,
//               style: Theme.of(context).textTheme.titleSmall,
//             ),
//             TextButton.icon( 
//               onPressed: () async {
//                 await showDialog(
//                   context: context,
//                   builder: (context) => Dialog.fullscreen(
//                     child: PickLocationPage(
//                       initialLocation: widget.pickedLocationNotifier.value,
//                       onSelectPressed: (value) {
//                         widget.pickedLocationNotifier.value = value;
//                         debugPrint("pickedLocationNotifier.value: $value");
//                         setState(() {
                          
//                         });
//                         GoRouter.of(context).pop();
//                       },
//                       onBackPressed: context.pop,
//                       onLocationChanged: (value) {
                        
//                       },
//                       // onSelectPressed: context.pop,
//                     ),
//                   ),
//                 );
//               },
//               icon: Icon(
//                 Icons.location_on_outlined,
//                 color: context.colorScheme.primary,
//                 size: 20,
//               ),
//               label: Text(
//                 context.l10n.relocate,
//                 style: TextStyle(
//                   color: context.colorScheme.primary,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 padding: Insets.smallAll,
//               ),
//             ),
//           ],
//         ),
//         InkWell(
//           onTap: () async {
//             await showDialog(
//               context: context,
//               builder: (context) => Dialog.fullscreen(
//                 child: ValueListenableBuilder(
//                     valueListenable: widget.pickedLocationNotifier,
//                     builder: (context, pickedLocation, child) {
//                       return PickLocationPage(
//                         initialLocation: pickedLocation,
//                         onSelectPressed: (value) {
//                         widget.pickedLocationNotifier.value = value;
//                         debugPrint("pickedLocationNotifier.value: $value");
//                         setState(() {
                          
//                         });
//                         GoRouter.of(context).pop();
//                       },
//                       onBackPressed: context.pop,
//                       onLocationChanged: (value) {
                        
//                       },
//                       // onSelectPressed: context.pop,
//                       );
//                     }),
//               ),
//             );
//           },
//           borderRadius: BorderSize.extraSmallRadius,
//           child: Container(
//               height: 200,
//               width: context.width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderSize.mediumRadius,
//                 border: Border.all(color: Theme.of(context).dividerColor),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderSize.mediumRadius,
//                 child: CurrentLocationCard(
//                   pickedLocationNotifier: widget.pickedLocationNotifier,
//                 ),
//               )),
//         ),
//       ],
//     );
//   }
// }
