class Place {
  final String id;
  final String name;
  final String description;
  final String category;
  final String thumbnail;
  final String address;
  final double latitude;
  final double longitude;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromFirestore(Map<String, dynamic> data, String documentId) {
    double parseDouble(dynamic value) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return Place(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      address: data['address'] ?? '',
      latitude: parseDouble(data['latitude']),
      longitude: parseDouble(data['longitude']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'thumbnail': thumbnail,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
