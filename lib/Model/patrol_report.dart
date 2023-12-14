class EmergencyAlert {
  String? id; // Made nullable
  String message;
  String? imageUrl; // Made nullable
  DateTime? timestamp; // Made nullable

  EmergencyAlert({this.id, required this.message, this.imageUrl, this.timestamp});

}
