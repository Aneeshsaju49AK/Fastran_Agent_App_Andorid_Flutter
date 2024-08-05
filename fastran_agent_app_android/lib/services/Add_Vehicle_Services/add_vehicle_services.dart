
import 'package:fastran_agent_app_android/export/export.dart';
import 'package:http/http.dart' as http;
Future<void> submitVehicleData(AddVehicle vehicle ,BuildContext context) async {
    final String apiUrl = "https://fastran-public-apim.azure-api.net/agentapi/vehicle";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(vehicle.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Successfully submitted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle added successfully')),
        
      );
      
      
    } else {
      // Error occurred
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add vehicle')),
      );
    }
  }



void validateAndSubmit(
  BuildContext context,
  TextEditingController nameController,
  TextEditingController regNumberController,
  TextEditingController mobileNumberController,
  int? selectedIndex,
  List<String> vehicleBrand,
) {
  if (nameController.text.isEmpty ||
      regNumberController.text.isEmpty ||
      mobileNumberController.text.isEmpty) {
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
  print("Selected vehicle: ${vehicleBrand[selectedIndex]}");
  var uuid = Uuid();
  String vehicleId = uuid.v4().toString();
  AddVehicle vehicle = AddVehicle(
    id: vehicleId,
    mobile: mobileNumberController.text,
    rcNumber: regNumberController.text,
    name: nameController.text,
    vehicleType: vehicleBrand[selectedIndex],
    city: "Erode",
    address: "sydfhvsfd",
    latitude: "34.6533",
    longitude: "45.3432",
    date: DateTime.now().toIso8601String(),
  );

  // Submit the form
  submitVehicleData(vehicle, context);
}