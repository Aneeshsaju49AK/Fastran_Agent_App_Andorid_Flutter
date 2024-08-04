import 'dart:async';
import 'package:fastran_agent_app_android/export/export.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class HomeGoogleMap extends StatefulWidget {
  const HomeGoogleMap({super.key});

  @override
  State<HomeGoogleMap> createState() => _HomeGoogleMapState();
}

class _HomeGoogleMapState extends State<HomeGoogleMap> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const LatLng indiaLocation = LatLng(28.6139, 77.2090);
  loc.LocationData? _currentPosition;
  final loc.Location _location = loc.Location();
  Marker? _marker;

  CameraPosition _initialCameraPosition = const CameraPosition(
    target: indiaLocation,
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    print("i'm here");
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await _location.getLocation();

    if (_currentPosition != null) {
      _initialCameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
        zoom: 14.4746,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
      setState(() {});
    }
  }

  Future<void> _searchPlace(String place) async {
    List<geocoding.Location> locations = await geocoding.locationFromAddress(place);
    if (locations.isNotEmpty) {
      final GoogleMapController controller = await _controller.future;
      LatLng target = LatLng(locations.first.latitude, locations.first.longitude);
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: 14.4746,
        ),
      ));

      setState(() {
        _marker = Marker(
          markerId: MarkerId(target.toString()),
          position: target,
          infoWindow: InfoWindow(
            title: place,
          ),
        );
      });
    }
  }
 void _addMarker(LatLng position) {
    setState(() {
      _marker = Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(
          title: 'Custom Location',
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _marker != null ? {_marker!} : {},
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _addMarker,
            ),
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              top: 20,
              left: 60,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                  onSubmitted: (value) {
                    _searchPlace(value);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  // Implement the functionality for the button here.
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    heightSize: 17,
                    widthSize: 1.2,
                    label: 'Verify & Proceed',
                    height: height,
                    width: width,
                    color: Colors.black,
                    labelColor: Colors.white,
                    boarderRadiusSize: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
