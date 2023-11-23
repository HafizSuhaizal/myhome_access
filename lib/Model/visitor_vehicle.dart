class VisitorVehicle {
  String plateNumber;
  DateTime accessStartTime;
  DateTime accessEndTime;
  String visitorName;
  String typeOfAccess;
  String vehicleType;
  String status;

  VisitorVehicle({
    required this.plateNumber,
    required this.accessStartTime,
    required this.accessEndTime,
    required this.visitorName,
    required this.typeOfAccess,
    required this.vehicleType,
    this.status = 'Access Granted',
  });

  bool get isAccessExpired => DateTime.now().isAfter(accessEndTime);

  void updateStatus() {
    if (isAccessExpired) {
      status = 'Access Denied';
    }
  }
}
