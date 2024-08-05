
import 'package:fastran_agent_app_android/export/export.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;

class HomeGoogleMap extends StatefulWidget {
  final LocationModel? initialLocation;
  const HomeGoogleMap({super.key, this.initialLocation});

  @override
  State<HomeGoogleMap> createState() => _HomeGoogleMapState();
}

class _HomeGoogleMapState extends State<HomeGoogleMap> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const LatLng indiaLocation = LatLng(28.6139, 77.2090);
  loc.LocationData? _currentPosition;
  final loc.Location _location = loc.Location();
  Marker? _marker;

  String city = "Kochi"; // Default city value
  double latitude = 0.0;
  double longitude = 0.0;
  String address = "Default Address";

  CameraPosition _initialCameraPosition = const CameraPosition(
    target: indiaLocation,
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _setInitialLocation(widget.initialLocation!);
    } else {
      _getCurrentLocation();
    }
  }
  void _setInitialLocation(LocationModel location) {
  setState(() {
    try {
      // Parse latitude and longitude from string to double
      latitude = location.latitude ;
      longitude = location.longitude ;

      // Assign other location data
      address = location.address;
      city = location.city;

      // Update the camera position and marker
      _initialCameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );

      _marker = Marker(
        markerId: MarkerId('${latitude}_${longitude}'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: address,
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
      });
    } catch (e) {
      print('Error parsing location data: $e');
    }
  });
}

  Future<void> _getCurrentLocation() async {
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
    List<geocoding.Location> locations;
    try {
      locations = await geocoding.locationFromAddress(place);
    } catch (e) {
      print("Error occurred while searching for place: $e");
      return;
    }

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
        latitude = target.latitude;
        longitude = target.longitude;
        address = place; // Assuming the address is the searched place
        city = "City"; // You might want to set this dynamically
      });
    }
  }

  void _addMarker(LatLng position) async {
  List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);
  String newAddress = "";
  String newCity = "";

  if (placemarks.isNotEmpty) {
    geocoding.Placemark place = placemarks[0];
    newAddress = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    newCity = place.locality ?? "City"; // Default to "City" if locality is null
  }

  setState(() {
    _marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(
        title: newAddress,
      ),
    );
    latitude = position.latitude;
    longitude = position.longitude;
    address = newAddress;
    city = newCity;
  });

  print("${newAddress}/////////////"); // Update this as needed
}

  Future<void> _postLocation(String city, double latitude, double longitude, String address) async {
    final url = 'https://fastran-public-apim.azure-api.net/agentapi/location';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'city': city,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        print('Location posted successfully.');
      } else {
        print('Failed to post location. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to post location: $e');
    }
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
                  if (latitude != 0.0 && longitude != 0.0 && address.isNotEmpty && city.isNotEmpty) {
                    _postLocation(city, latitude, longitude, address);
                  } else {
                    print('Location details are not set properly.');
                  }
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
