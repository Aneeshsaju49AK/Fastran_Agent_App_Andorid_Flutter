import 'package:fastran_agent_app_android/export/export.dart';
import 'package:fastran_agent_app_android/models/Addvehicle_Model/add_vehicle_model.dart';
import 'package:fastran_agent_app_android/services/Add_Vehicle_Services/add_vehicle_services.dart';
import 'package:fastran_agent_app_android/views/screen/otpverification_screen/home_otp_screen.dart';
import 'package:uuid/uuid.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> statusOptions = ['Active', 'Inactive', 'Pending'];
  String? selectedStatus;
  int? selectedIndex;
 
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<String> imagesVehicle = [
    "asstes/images/image copy 2.png",
    "asstes/images/image copy 3.png",
    "asstes/images/image copy 4.png",
  ];

  final List<String> vehicleBrand = [
    "PickUp Truck",
    "Ape",
    "Ace",
  ];
  @override
  void dispose() {
    nameController.dispose();
    regNumberController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }
  void validateAndSubmit() {
    if (nameController.text.isEmpty || regNumberController.text.isEmpty || mobileNumberController.text.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (selectedIndex == null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please choose a vehicle')),
      );
      return;
    }

    // Submit the form
    print("Name: ${nameController.text}");
    print("Registration Number: ${regNumberController.text}");
    print("${mobileNumberController.text}");
    print("Selected vehicle: ${vehicleBrand[selectedIndex!]}");
     var uuid = Uuid();
     String vehicleId =uuid.v4().toString();
    AddVehicle vehicle = AddVehicle(
      id: vehicleId,
      mobile: mobileNumberController.text,
      rcNumber: regNumberController.text,
      name: nameController.text,
      vehicleType: vehicleBrand[selectedIndex!],
      city: "Erode",
      address: "sydfhvsfd",
      latitude: "34.6533",
      longitude: "45.3432",
      date: DateTime.now().toIso8601String(),
    );

    // Submit the form
    submitVehicleData(vehicle,context);
    print(uuid.toString());
    print(uuid.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainHeaderCommon(
                height: height,
                width: width,
                isIconwidgetNeeded: false,
                headLabel: "Add Vehicle",
                subLabel: 'Provide information about your vehicle',
              ),
              CustompaddingOnly(
                top: 10,
                childWidget: CommonContainer(
                  heightSize: 1.5,
                  widthSize: 1,
                  height: height,
                  color: Colors.white,
                  width: width,
                  border: BorderDirectional(
                    top: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  childWidget: Column(
                    children: [
                      CommonHeadWithTextfield(height: height, width: width,label: 'Registration number',controller: regNumberController,),
                      CommonContainer(
                        heightSize: 5,
                        widthSize: 1,
                        height: height,
                        width: width,
                        childWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustompaddingOnly(
                              left: 8,
                              childWidget: CustomText(
                                label: "Choose Vehicle",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CommonContainer(
                              height: height,
                              heightSize: 7,
                              width: width,
                              widthSize: 1,
                              childWidget: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imagesVehicle.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CommonContainer(
                                            heightSize: 10.5,
                                            widthSize: 3.7,
                                            height: height,
                                            boarderRadiusSize: 15,
                                            width: width,
                                            border: Border.all(
                                              color: selectedIndex == index
                                                  ? Colors.blue
                                                  : Colors.black,
                                              style: BorderStyle.solid,
                                              width: 1.5,
                                            ),
                                            color: selectedIndex == index
                                                ? Colors.blue.withOpacity(0.3)
                                                : Colors.white,
                                            childWidget: Image.asset(
                                              imagesVehicle[index],
                                              scale: 2,
                                            ),
                                          ),
                                          CustomText(
                                            label: vehicleBrand[index],
                                            color: selectedIndex == index
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonContainer(
                        heightSize: 3.4,
                        widthSize: 1,
                        height: height,
                        width: width,
                        childWidget: Column(
                          children: [
                            CommonHeadWithTextfield(
                                height: height, width: width,
                                label: 'Name',
                                controller: nameController,),
                            CommonHeadWithTextfield(
                                height: height, width: width,
                                label: 'Mobile No',
                                controller: mobileNumberController,),
                            CommonContainer(
                              heightSize: 10,
                              widthSize: 1,
                              height: height,
                              width: width,
                              childWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustompaddingOnly(
                                    left: 8,
                                    childWidget: CustomText(
                                      label: "Status",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CommonContainer(
                                      heightSize: 19,
                                      widthSize: 1.1,
                                      height: height,
                                      width: width,
                                      boarderRadiusSize: 10,
                                      color: Colors.black,
                                      childWidget: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: DropdownButton<String>(
                                          value: selectedStatus,
                                          isExpanded: true,
                                          dropdownColor: Colors.white,
                                          underline: SizedBox(),
                                          hint: CustomText(
                                            label: selectedStatus ?? "choose Status",
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          items: statusOptions
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: CustomText(
                                                label: value,
                                                color: Colors.black,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedStatus = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    validateAndSubmit();
                  },
                  child: CustomButton(
                    heightSize: 15,
                    widthSize: 1.1,
                    label: 'Submit',
                    height: height,
                    color: Colors.black,
                    labelColor: Colors.white,
                    width: width,
                   
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonHeadWithTextfield extends StatelessWidget {
  const CommonHeadWithTextfield({
    super.key,
    required this.height,
    required this.width,
    required this.label,
    required this.controller,
  });

  final double height;
  final double width;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      heightSize: 11,
      widthSize: 1,
      height: height,
      width: width,
      childWidget: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              label: label,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: CommonContainer(
                height: height,
                width: width,
                widthSize: 1,
                heightSize: 22,
                childWidget: Customtexteditfield(
                    keyboardType: TextInputType.emailAddress,
                    controller: controller,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
