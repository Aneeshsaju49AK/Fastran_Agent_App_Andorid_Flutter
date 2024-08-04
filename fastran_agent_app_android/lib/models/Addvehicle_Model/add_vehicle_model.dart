// vehicle.dart
class AddVehicle {
  String id;
  String mobile;
  String rcNumber;
  String name;
  String vehicleType;
  String city;
  String address;
  String latitude;
  String longitude;
  String date;

  AddVehicle({
    required this.id,
    required this.mobile,
    required this.rcNumber,
    required this.name,
    required this.vehicleType,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "mobile": mobile,
      "rcNumber": rcNumber,
      "name": name,
      "vehicleType": vehicleType,
      "city": city,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "date": date,
    };
  }
}
