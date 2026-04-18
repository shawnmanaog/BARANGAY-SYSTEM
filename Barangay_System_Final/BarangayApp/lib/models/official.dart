enum Position {
  chairman('Barangay Chairman'),
  vice('Vice Chairman'),
  kagawad('Kagawad'),
  secretary('Barangay Secretary'),
  treasurer('Barangay Treasurer'),
  healthWorker('Health Worker'),
  tanod('Barangay Tanod');

  final String label;
  const Position(this.label);
}

class Official {
  final String id;
  final String firstName;
  final String lastName;
  final Position position;
  final String email;
  final String phone;
  final DateTime termStart;
  final DateTime termEnd;
  bool isActive;

  Official({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.email,
    required this.phone,
    required this.termStart,
    required this.termEnd,
    this.isActive = true,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'position': position.name,
      'email': email,
      'phone': phone,
      'termStart': termStart.toIso8601String(),
      'termEnd': termEnd.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory Official.fromJson(Map<String, dynamic> json) {
    return Official(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      position: Position.values.byName(json['position']),
      email: json['email'],
      phone: json['phone'],
      termStart: DateTime.parse(json['termStart']),
      termEnd: DateTime.parse(json['termEnd']),
      isActive: json['isActive'] ?? true,
    );
  }
}
