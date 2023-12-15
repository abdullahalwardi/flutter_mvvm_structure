// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:app/common_lib.dart';
// import 'package:app/src/location/current_location_card.dart';
// import 'package:app/utils/widgets/flex_padded.dart';

// class UseCurrentLocationCard extends StatelessWidget {
//   const UseCurrentLocationCard({
//     super.key,
//     required this.press,
//     this.initialLocation,
//   });

//   final VoidCallback press;
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
//               context.l10n.pickProjectLocation,
//               style: Theme.of(context).textTheme.titleSmall,
//             ),
//             TextButton.icon(
//               onPressed: press,
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
//           onTap: press,
//           borderRadius: BorderSize.mediumRadius,
//           child: Container(
//               height: 200,
//               width: context.width,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     const BorderRadius.all(Radius.circular(BorderSize.medium)),
//                 border: Border.all(color: Theme.of(context).dividerColor),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderSize.mediumRadius,
//                 child: CurrentLocationCard(
//                   initialLocation: initialLocation,
//                 ),
//               )
//               // ListTile(
//               //   leading: CircleAvatar(
//               //     radius: 24,
//               //     backgroundColor: context.colorScheme.primary,
//               //     child: SvgPicture.asset(
//               //       Assets.assetsSvgMylocation,
//               //       color: Colors.white,
//               //     ),
//               //   ),
//               //   title: Text(
//               //     context.l10n.pickProjectLocation,
//               //     style: Theme.of(context).textTheme.titleSmall,
//               //   ),
//               //   // subtitle: Padding(
//               //   //   padding: const EdgeInsets.only(top: Insets.medium / 2),
//               //   //   child: Text(
//               //   //     "John Nowakowska, Zabiniec",
//               //   //     maxLines: 1,
//               //   //     overflow: TextOverflow.ellipsis,
//               //   //     style: Theme.of(context).textTheme.bodySmall,
//               //   //   ),
//               //   // ),
//               //   trailing: Icon(Icons.arrow_forward_ios,
//               //       color: Theme.of(context).iconTheme.color),
//               // ),
//               ),
//         ),
//       ],
//     );
//   }
// }
