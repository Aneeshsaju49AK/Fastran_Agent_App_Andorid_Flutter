import 'package:fastran_agent_app_android/export/export.dart';


class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  _HomeMapScreenState createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final ValueNotifier<List<LocationModel>> _locationsNotifier =
      ValueNotifier<List<LocationModel>>([]);

  @override
  void initState() {
    super.initState();
    LocationService.fetchLocations(_locationsNotifier);
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
                        physics:
                            ScrollPhysics(), // to avoid conflicts with SingleChildScrollView
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return InkWell(
                            onTap: () {
                              navigateToScreen(
                                  context,
                                  HomeGoogleMap(
                                    initialLocation: location,
                                  ));
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: CustomText(
                                              label: "#A ${location.city}",
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
