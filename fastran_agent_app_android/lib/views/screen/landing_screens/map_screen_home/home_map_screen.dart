import 'dart:convert';
import 'package:fastran_agent_app_android/export/export.dart';
import 'package:fastran_agent_app_android/models/Get_location/get_location_model.dart';
import 'package:fastran_agent_app_android/views/screen/Google_Map/home_google_map.dart';
import 'package:fastran_agent_app_android/views/screen/otpverification_screen/home_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  _HomeMapScreenState createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final ValueNotifier<List<LocationModel>> _locationsNotifier = ValueNotifier<List<LocationModel>>([]);

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    const url = 'https://fastran-public-apim.azure-api.net/agentapi/location?offset=0&limit=10';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<LocationModel> locations = data.map((json) => LocationModel.fromJson(json)).toList();
        _locationsNotifier.value = locations;
      } else {
        print('Failed to load locations. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load locations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainHeaderCommon(
                height: height,
                width: width,
                isIconwidgetNeeded: true,
                headLabel: "Locations",
                subLabel: 'All Marked locations',
                handleIconButtom: () {
                  navigateToScreen(context, HomeGoogleMap());
                },
              ),
              ValueListenableBuilder<List<LocationModel>>(
                valueListenable: _locationsNotifier,
                builder: (context, locations, child) {
                  return CustompaddingOnly(
                    top: 10,
                    childWidget: CommonContainer(
                      heightSize: 1.5,
                      widthSize: 1,
                      height: height,
                      width: width,
                      border: BorderDirectional(
                        top: BorderSide(
                          style: BorderStyle.solid,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      childWidget: ListView.builder(
                        shrinkWrap: true, // to avoid unbounded height error
                        physics: ScrollPhysics(), // to avoid conflicts with SingleChildScrollView
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return InkWell(
                            onTap:(){
                               navigateToScreen(context,HomeGoogleMap(initialLocation: location,));
                            },
                            child: CommonContainer(
                              heightSize: 10,
                              widthSize: 1,
                              height: height,
                              width: width,
                              border: BorderDirectional(
                                top: BorderSide(
                                  style: BorderStyle.solid,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              childWidget: Row(
                                children: [
                                  CommonContainer(
                                    heightSize: 10,
                                    widthSize: 4,
                                    height: height,
                                    width: width,
                                    childWidget: Center(
                                      child: CircleAvatar(
                                        radius: 32,
                                        child: Icon(Icons.location_pin),
                                      ),
                                    ),
                                  ),
                                  CommonContainer(
                                    heightSize: 10,
                                    widthSize: 1.4,
                                    height: height,
                                    width: width,
                                    childWidget: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: CustomText(
                                              label: "#A ${location.city} Terminal",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          CustomText(
                                            label: location.city,
                                            color: Colors.grey,
                                          ),
                                          CustomText(
                                            label: location.address,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
