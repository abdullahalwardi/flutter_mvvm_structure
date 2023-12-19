// import 'dart:async';

// import 'package:app/common_lib.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PickLocationPage extends StatefulHookConsumerWidget {
//   const PickLocationPage({
//     super.key,
//     this.initialLocation,
//     required this.onLocationChanged,
//     required this.onBackPressed,
//     required this.onSelectPressed,
//   });

//   final LatLng? initialLocation;
//   final ValueChanged<LatLng> onLocationChanged;
//   final VoidCallback onBackPressed;
//   final VoidCallback onSelectPressed;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _PickLocationPageState();
// }

// class _PickLocationPageState extends ConsumerState<PickLocationPage> {
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
//         context.go(RoutesDocument.login);
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
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
//           : Stack(
//               children: [
//                 GoogleMap(
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   zoomControlsEnabled: false,
//                   onMapCreated: _controller.complete,
//                   initialCameraPosition: CameraPosition(
//                     target: widget.initialLocation ?? _currentLocation!,
//                     zoom: 18,
//                   ),
//                   onCameraMove: (position) {
//                     setState(() {
//                       marker = Marker(
//                         markerId: MarkerId(position.target.toString()),
//                         position: position.target,
//                         icon: _currentLocationIcon,
//                       );
//                       widget.onLocationChanged(LatLng(
//                           position.target.latitude, position.target.longitude));
//                     });
//                   },
//                   markers: {if (_currentLocation != null) marker!},
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 6),
//                     child: IconButton(
//                       onPressed: widget.onBackPressed,
//                       icon: const Icon(Icons.arrow_back_ios_new_outlined),
//                     ),
//                   ),
//                 ),
//                 const Align(
//                   alignment: Alignment.topCenter,
//                   child: Padding(
//                     padding: EdgeInsets.all(Insets.medium),
//                     child: Text(
//                       "حدد موقعك",
//                       style: TextStyle(
//                         color: Color(0xff293740),
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     width: context.width,
//                     padding: const EdgeInsets.all(Insets.medium),
//                     child: FilledButton(
//                       onPressed: _currentLocation == null
//                           ? null
//                           : () {
//                               widget.onLocationChanged(
//                                 LatLng(
//                                   _currentLocation!.latitude,
//                                   _currentLocation!.longitude,
//                                 ),
//                               );
//                               widget.onSelectPressed();
//                             },
//                       child: const Text("تحديد"),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: Insets.extraLarge * 2),
//         child: FloatingActionButton(
//           onPressed: getCurrentLocation,
//           child: const Icon(Icons.gps_fixed_outlined),
//         ),
//       ),
//     );
//   }
// }
