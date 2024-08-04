import 'dart:convert';
import 'package:fastran_agent_app_android/models/Vehicle_Model/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  static const String url = 'https://fastran-public-apim.azure-api.net/agentapi/vehicle?offset=0&limit=10';

  static Future<List<Vehicle>> fetchVehicles() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((vehicle) => Vehicle.fromJson(vehicle)).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }
}
