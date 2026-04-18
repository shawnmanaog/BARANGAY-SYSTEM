import 'package:uuid/uuid.dart';
import '../models/complaint.dart';

class ComplaintService {
  static final ComplaintService _instance = ComplaintService._internal();
  final List<Complaint> _complaints = [];

  factory ComplaintService() {
    return _instance;
  }

  ComplaintService._internal();

  List<Complaint> getAll() => List.from(_complaints);

  List<Complaint> getByComplainantId(String complainantId) {
    return _complaints.where((c) => c.complainantId == complainantId).toList();
  }

  List<Complaint> getByStatus(ComplaintStatus status) {
    return _complaints.where((c) => c.status == status).toList();
  }

  Complaint? getById(String id) {
    try {
      return _complaints.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  void fileComplaint(
    String complainantId,
    String respondentName,
    String description,
    String location,
    String category,
  ) {
    final complaint = Complaint(
      id: const Uuid().v4(),
      complainantId: complainantId,
      respondentName: respondentName,
      description: description,
      location: location,
      status: ComplaintStatus.filed,
      filedDate: DateTime.now(),
      category: category,
    );
    _complaints.add(complaint);
  }

  void startInvestigation(String id) {
    final complaint = getById(id);
    if (complaint != null) {
      complaint.status = ComplaintStatus.investigating;
    }
  }

  void resolveComplaint(String id, String resolutionNotes) {
    final complaint = getById(id);
    if (complaint != null) {
      complaint.status = ComplaintStatus.resolved;
      complaint.resolvedDate = DateTime.now();
      complaint.resolutionNotes = resolutionNotes;
    }
  }

  void closeComplaint(String id) {
    final complaint = getById(id);
    if (complaint != null) {
      complaint.status = ComplaintStatus.closed;
    }
  }

  int getTotalComplaints() => _complaints.length;

  int getPendingComplaints() => getByStatus(ComplaintStatus.filed).length;

  int getResolvedComplaints() => getByStatus(ComplaintStatus.resolved).length;
}
