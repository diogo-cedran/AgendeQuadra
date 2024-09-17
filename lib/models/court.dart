class Court {
  final String id;
  final String name;
  final String type; // Ex: Futsal, Vôlei, Society
  final double pricePerHour;
  final bool isAvailable;

  Court({
    required this.id,
    required this.name,
    required this.type,
    required this.pricePerHour,
    required this.isAvailable,
  });
}
