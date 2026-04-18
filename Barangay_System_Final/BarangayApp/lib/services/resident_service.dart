import 'package:uuid/uuid.dart';
import '../models/resident.dart';

class ResidentService {
  static final ResidentService _instance = ResidentService._internal();
  final List<Resident> _residents = [];

  factory ResidentService() {
    return _instance;
  }

  ResidentService._internal();

  List<Resident> getAll() => List.from(_residents);

  Resident? getById(String id) {
    try {
      return _residents.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Resident> searchByName(String query) {
    return _residents
        .where((r) => r.fullName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Resident> getVerified() {
    return _residents.where((r) => r.isVerified).toList();
  }

  List<Resident> getUnverified() {
    return _residents.where((r) => !r.isVerified).toList();
  }

  void addResident(
    String firstName,
    String lastName,
    String email,
    String phone,
    String address,
    String barangay,
    DateTime dateOfBirth,
    String gender,
    String civilStatus,
  ) {
    final resident = Resident(
      id: const Uuid().v4(),
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      address: address,
      barangay: barangay,
      dateOfBirth: dateOfBirth,
      gender: gender,
      civilStatus: civilStatus,
      registeredDate: DateTime.now(),
      isVerified: false,
    );
    _residents.add(resident);
  }

  void updateResident(String id, Resident updatedResident) {
    final index = _residents.indexWhere((r) => r.id == id);
    if (index != -1) {
      _residents[index] = updatedResident;
    }
  }

  void verifyResident(String id) {
    final resident = getById(id);
    if (resident != null) {
      resident.isVerified = true;
    }
  }

  void deleteResident(String id) {
    _residents.removeWhere((r) => r.id == id);
  }

  int getTotalResidents() => _residents.length;

  int getVerifiedCount() => getVerified().length;
}
