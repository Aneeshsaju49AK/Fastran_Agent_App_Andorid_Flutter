import 'dart:convert';

import 'package:fastran_agent_app_android/export/export.dart';
import 'package:fastran_agent_app_android/models/Addvehicle_Model/add_vehicle_model.dart';
import 'package:flutter/foundation.dart';
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
