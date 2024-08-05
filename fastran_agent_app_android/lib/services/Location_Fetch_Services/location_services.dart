import 'package:fastran_agent_app_android/export/export.dart';
import 'package:http/http.dart' as http;
// Adjust the import based on your actual model location

class LocationService {
  static Future<void> fetchLocations(
      ValueNotifier<List<LocationModel>> locationsNotifier) async {
    const url =
        'https://fastran-public-apim.azure-api.net/agentapi/location?offset=0&limit=10';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<LocationModel> locations =
            data.map((json) => LocationModel.fromJson(json)).toList();
        locationsNotifier.value = locations;
      } else {
        print('Failed to load locations. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load locations: $e');
    }
  }
}
