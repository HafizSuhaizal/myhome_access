class EmergencyAlert {
  String? id; // Made nullable
  String type;
  String message;
  String? imageUrl; // Made nullable
  DateTime? timestamp; // Made nullable

  EmergencyAlert({this.id, required this.type, required this.message, this.imageUrl, this.timestamp});

}
