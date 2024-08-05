
import 'package:fastran_agent_app_android/export/export.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  // static const String url = 'https://fastran-public-apim.azure-api.net/agentapi/vehicle?offset=0&limit=10';

  // static Future<List<Vehicle>> fetchVehicles() async {
  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((vehicle) => Vehicle.fromJson(vehicle)).toList();
  //   } else {
  //     throw Exception('Failed to load vehicles');
  //   }
  // }

  static Future<void> fetchVehicles(ValueNotifier<List<Vehicle>> vehicleNotifier) async {
    const url = 'https://fastran-public-apim.azure-api.net/agentapi/vehicle?offset=0&limit=10';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Vehicle> locations = data.map((json) => Vehicle.fromJson(json)).toList();
        vehicleNotifier.value = locations;
      } else {
        print('Failed to load locations. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load locations: $e');
    }
  }
}
