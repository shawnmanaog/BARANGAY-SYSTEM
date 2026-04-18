import 'package:uuid/uuid.dart';
import '../models/official.dart';

class OfficialService {
  static final OfficialService _instance = OfficialService._internal();
  final List<Official> _officials = [];

  factory OfficialService() {
    return _instance;
  }

  OfficialService._internal();

  List<Official> getAll() => List.from(_officials);

  List<Official> getActive() {
    return _officials.where((o) => o.isActive).toList();
  }

  Official? getById(String id) {
    try {
      return _officials.firstWhere((o) => o.id == id);
    } catch (e) {
      return null;
    }
  }

  Official? getByPosition(Position position) {
    try {
      return _officials.firstWhere((o) => o.position == position && o.isActive);
    } catch (e) {
      return null;
    }
  }

  void addOfficial(
    String firstName,
    String lastName,
    Position position,
    String email,
    String phone,
    DateTime termStart,
    DateTime termEnd,
  ) {
    final official = Official(
      id: const Uuid().v4(),
      firstName: firstName,
      lastName: lastName,
      position: position,
      email: email,
      phone: phone,
      termStart: termStart,
      termEnd: termEnd,
      isActive: true,
    );
    _officials.add(official);
  }

  void updateOfficial(String id, Official updatedOfficial) {
    final index = _officials.indexWhere((o) => o.id == id);
    if (index != -1) {
      _officials[index] = updatedOfficial;
    }
  }

  void deactivateOfficial(String id) {
    final official = getById(id);
    if (official != null) {
      official.isActive = false;
    }
  }

  void removeOfficial(String id) {
    _officials.removeWhere((o) => o.id == id);
  }

  int getTotalOfficials() => _officials.length;
}
