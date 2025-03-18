// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:elixir/common_lib.dart';

// class CurrentLocationCard extends StatefulHookConsumerWidget {
//   const CurrentLocationCard({
//     super.key,
//     required this.pickedLocationNotifier,
//   });

//   final ValueNotifier<LatLng?> pickedLocationNotifier;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _CurrentLocationCardState();
// }

// class _CurrentLocationCardState extends ConsumerState<CurrentLocationCard> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   Marker? marker;

//   @override
//   void initState() {
//     super.initState();

//     widget.pickedLocationNotifier.addListener(_updateMarker);
//     _initMap();
//   }

//   Future<void> _initMap() async {
//     final location = widget.pickedLocationNotifier.value;
//     if (location != null) {
//       marker = Marker(
//         markerId: MarkerId(location.toString()),
//         position: location,
//       );
//       final controller = await _controller.future;
//       controller.moveCamera(CameraUpdate.newLatLngZoom(location, 15));
//       if (mounted) setState(() {});
//     }
//   }

//   void _updateMarker() async {
//     final location = widget.pickedLocationNotifier.value;
//     if (location != null) {
//       final controller = await _controller.future;
//       controller.animateCamera(CameraUpdate.newLatLng(location));

//       setState(() {
//         marker = Marker(
//           markerId: MarkerId(location.toString()),
//           position: location,
//         );
//       });
//     }
//   }

//   @override
//   void dispose() {
//     widget.pickedLocationNotifier.removeListener(_updateMarker);
//     _controller.future.then((c) => c.dispose());
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.pickedLocationNotifier.value == null
//         ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
//         : GoogleMap(
//             scrollGesturesEnabled: false,
//             zoomGesturesEnabled: false,
//             tiltGesturesEnabled: false,
//             rotateGesturesEnabled: false,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             onMapCreated: _controller.complete,
//             initialCameraPosition: CameraPosition(
//               target: widget.pickedLocationNotifier.value!,
//               zoom: 15,
//             ),
//             markers: {if (marker != null) marker!},
//           );
//   }
// }
