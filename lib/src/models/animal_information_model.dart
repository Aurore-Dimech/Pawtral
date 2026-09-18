class AnimalInformation {
  const AnimalInformation({
    required this.id,
    required this.animalName,
    required this.imagePath,
    required this.createdAt,
    this.latitude,
    this.longitude,
  });

  final String id;
  final String animalName;
  final String imagePath;
  final DateTime createdAt;
  final double? latitude;
  final double? longitude;
}