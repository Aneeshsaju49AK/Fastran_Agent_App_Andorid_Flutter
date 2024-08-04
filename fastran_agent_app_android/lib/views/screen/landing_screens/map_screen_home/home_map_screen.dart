import 'dart:async';

import 'package:fastran_agent_app_android/export/export.dart';
import 'package:fastran_agent_app_android/views/screen/Google_Map/home_google_map.dart';
import 'package:fastran_agent_app_android/views/screen/otpverification_screen/home_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class HomeMapScreen extends StatefulWidget {
//   const HomeMapScreen({super.key});

//   @override
//   State<HomeMapScreen> createState() => _HomeMapScreenState();
// }

// class _HomeMapScreenState extends State<HomeMapScreen> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//  static const LatLng indiaLocation = LatLng(28.6139, 77.2090);

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: indiaLocation,
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),

//     );
//   }

// }
class HomeMapScreen extends StatelessWidget {
  const HomeMapScreen({super.key});

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
              handleIconButtom: (){
                navigateToScreen(context, HomeGoogleMap());
              },
            ),
            SingleChildScrollView(
              child: CustompaddingOnly(
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
                            width: 1
                          )
                        ),
                  
                  childWidget: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CommonContainer(
                        heightSize: 10,
                        widthSize: 1,
                        height: height,
                        width: width,
                        
                         border: BorderDirectional(
                          top: BorderSide(
                            style: BorderStyle.solid,
                             strokeAlign: BorderSide.strokeAlignCenter,
                            color: Colors.grey.withOpacity(0.3),
                            width: 1
                          )
                        ),
                        childWidget: Row(
                          children: [
                            CommonContainer(heightSize: 10, widthSize: 4, height: height, width: width, 
                            childWidget: Center(
                              child: CircleAvatar(
                                radius: 32,
                                child: Icon(Icons.location_pin),
                              ),
                            ),),
                            CommonContainer(heightSize: 10, widthSize: 1.4, height: height, width: width, 
                            childWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(child: CustomText(label: "#A Chennai Airport Terminal",fontSize: 16,fontWeight: FontWeight.w700,)),
                                CustomText(label: "chennai",color: Colors.grey,)
                              ],
                            ),)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
                    ],
                  ),
          )),
    );
  }
}
