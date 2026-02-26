class BusModel {
  final String busNumber;
  final String driverName;
  final String arrivalTime;
  final String status;

  BusModel({
    required this.busNumber,
    required this.driverName,
    required this.arrivalTime,
    required this.status,
  });

  // بكرة لما يجهز الـ API هنستخدم الفنكشن دي لتحويل JSON لـ Object
  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      busNumber: json['bus_number'],
      driverName: json['driver_name'],
      arrivalTime: json['arrival_time'],
      status: json['status'],
    );
  }
}