class Vehicle {
  final String id;
  final String mobile;
  final String rcNumber;
  final String name;
  final String vehicleType;
  final String city;
  final String address;
  final String latitude;
  final String longitude;
  final String date;

  Vehicle({
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

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      mobile: json['mobile'],
      rcNumber: json['rcNumber'],
      name: json['name'],
      vehicleType: json['vehicleType'],
      city: json['city'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      date: json['date'],
    );
  }
}
