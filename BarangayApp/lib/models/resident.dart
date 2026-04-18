class Resident {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String barangay;
  final DateTime dateOfBirth;
  final String gender;
  final String civilStatus;
  final DateTime registeredDate;
  bool isVerified;

  Resident({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.barangay,
    required this.dateOfBirth,
    required this.gender,
    required this.civilStatus,
    required this.registeredDate,
    this.isVerified = false,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'barangay': barangay,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'civilStatus': civilStatus,
      'registeredDate': registeredDate.toIso8601String(),
      'isVerified': isVerified,
    };
  }

  factory Resident.fromJson(Map<String, dynamic> json) {
    return Resident(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      barangay: json['barangay'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      civilStatus: json['civilStatus'],
      registeredDate: DateTime.parse(json['registeredDate']),
      isVerified: json['isVerified'] ?? false,
    );
  }
}
