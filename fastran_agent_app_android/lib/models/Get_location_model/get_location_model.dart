class LocationModel {
  final String id;
  final String city;
  final double latitude;
  final double longitude;
  final String address;
  final String date;

  LocationModel({
    required this.id,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.date,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      city: json['city'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      address: json['address'],
      date: json['date'],
    );
  }
}
