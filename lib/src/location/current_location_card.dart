// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:app/common_lib.dart';

// class CurrentLocationCard extends StatefulHookConsumerWidget {
//   const CurrentLocationCard({
//     super.key,
//     this.initialLocation,
//   });

//   final LatLng? initialLocation;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _CurrentLocationCardState();
// }

// class _CurrentLocationCardState extends ConsumerState<CurrentLocationCard> {
//   // LatLng? _location;
//   // LatLng? _idleLocation;

//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   LatLng? _currentLocation;

//   late Marker? marker;

//   final _currentLocationIcon = BitmapDescriptor.defaultMarker;

//   @override
//   void initState() {
//     super.initState();

//     getCurrentLocation().then((value) {
//       marker = Marker(
//         markerId: MarkerId(
//           LatLng(_currentLocation!.latitude, _currentLocation!.longitude)
//               .toString(),
//         ),
//         position:
//             LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
//         icon: _currentLocationIcon,
//       );
//     });
//   }

//   Future getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         context.showErrorSnackBar(
//             context.l10n.locationPermissionIsRequiredToContinue);
//         context.pop();
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(context.l10n.locationPermissionIsDeniedForEver),
//             content: Text(context.l10n.locationPermissionIsRequiredToContinue),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   context.pop();
//                   context.pop();
//                 },
//                 child: Text(context.l10n.cancel),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Geolocator.openAppSettings();
//                 },
//                 child: Text(context.l10n.enableLocationPermission),
//               ),
//             ],
//           );
//         },
//       );
//     }

//     await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.bestForNavigation)
//         .then(
//       (location) async {
//         _currentLocation = LatLng(location.latitude, location.longitude);
//         setState(() {});

//         _controller.future.then((value) {
//           value.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 zoom: 13.5,
//                 target: LatLng(
//                     _currentLocation!.latitude, _currentLocation!.longitude),
//               ),
//             ),
//           );
//           setState(() {});
//         });
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.future.then((value) => value.dispose());
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentLocation == null || marker == null
//           ? const Center(
//               child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ))
//           : GoogleMap(
//               scrollGesturesEnabled: false,
//               zoomGesturesEnabled: false,
//               tiltGesturesEnabled: false,
//               rotateGesturesEnabled: false,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               zoomControlsEnabled: false,
//               onMapCreated: _controller.complete,
//               initialCameraPosition: CameraPosition(
//                 target: widget.initialLocation ?? _currentLocation!,
//                 zoom: 18,
//               ),
//               markers: {if (_currentLocation != null) marker!},
//             ),
//     );
//   }
// }
