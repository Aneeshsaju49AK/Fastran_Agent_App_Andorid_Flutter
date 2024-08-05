import 'package:fastran_agent_app_android/export/export.dart';

class HomeLoadScreen extends StatefulWidget {
  const HomeLoadScreen({super.key});

  @override
  State<HomeLoadScreen> createState() => _HomeLoadScreenState();
}

class _HomeLoadScreenState extends State<HomeLoadScreen> {
  final ValueNotifier<List<Vehicle>> _vehicles = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    VehicleService.fetchVehicles(_vehicles);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainHeaderCommon(
              height: height,
              width: width,
              isIconwidgetNeeded: true,
              headLabel: 'Manage Vehicles',
              subLabel: 'Vehicle information',
              handleIconButtom: () {
                navigateToScreen(context, HomeScreen());
              },
            ),
            CustompaddingOnly(
              top: 3.3,
              childWidget: CommonContainer(
                heightSize: 1.5,
                widthSize: 1,
                height: height,
                width: width,
                childWidget: ValueListenableBuilder<List<Vehicle>>(
                  valueListenable: _vehicles,
                  builder: (context, vehicles, _) {
                    return ListView.builder(
                      itemCount: vehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = vehicles[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CommonContainer(
                            heightSize: 11,
                            widthSize: 1.2,
                            height: height,
                            width: width,
                            boarderRadiusSize: 10,
                            color: Colors.white,
                            childWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CommonContainer(
                                  heightSize: 13,
                                  widthSize: 5,
                                  height: height,
                                  width: width,
                                  childWidget: Stack(
                                    clipBehavior: Clip.antiAlias,
                                    children: [
                                      CommonContainer(
                                        heightSize: 13,
                                        widthSize: 5,
                                        height: height,
                                        width: width,
                                        childWidget: Image.asset(
                                          'asstes/images/image.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned.directional(
                                        top: 28,
                                        start: 42,
                                        textDirection: TextDirection.ltr,
                                        child: const CircleAvatar(
                                          radius: 13,
                                          backgroundColor: Colors.black,
                                          child: Icon(Icons.check,
                                              color: Colors.white, size: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CommonContainer(
                                  heightSize: 13,
                                  widthSize: 3,
                                  height: height,
                                  width: width,
                                  childWidget: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(label: vehicle.vehicleType),
                                      CustomText(label: vehicle.name),
                                    ],
                                  ),
                                ),
                                CommonContainer(
                                  heightSize: 13,
                                  widthSize: 3,
                                  height: height,
                                  width: width,
                                  childWidget: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(label: 'Onboarded'),
                                      CustomButton(
                                        heightSize: 30,
                                        widthSize: 3,
                                        label: vehicle.rcNumber,
                                        height: height,
                                        width: width,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
