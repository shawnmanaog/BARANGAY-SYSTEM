import 'package:uuid/uuid.dart';
import '../models/document.dart';

class DocumentService {
  static final DocumentService _instance = DocumentService._internal();
  final List<Document> _documents = [];

  factory DocumentService() {
    return _instance;
  }

  DocumentService._internal();

  List<Document> getAll() => List.from(_documents);

  List<Document> getByResidentId(String residentId) {
    return _documents.where((d) => d.residentId == residentId).toList();
  }

  List<Document> getByStatus(DocumentStatus status) {
    return _documents.where((d) => d.status == status).toList();
  }

  List<Document> getPending() => getByStatus(DocumentStatus.pending);

  Document? getById(String id) {
    try {
      return _documents.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  void requestDocument(
    String residentId,
    DocumentType type,
    String purpose,
  ) {
    final document = Document(
      id: const Uuid().v4(),
      residentId: residentId,
      type: type,
      status: DocumentStatus.pending,
      requestedDate: DateTime.now(),
      purpose: purpose,
    );
    _documents.add(document);
  }

  void approveDocument(String id) {
    final document = getById(id);
    if (document != null) {
      document.status = DocumentStatus.approved;
      document.approvedDate = DateTime.now();
    }
  }

  void rejectDocument(String id, String reason) {
    final document = getById(id);
    if (document != null) {
      document.status = DocumentStatus.rejected;
      document.notes = reason;
    }
  }

  void releaseDocument(String id) {
    final document = getById(id);
    if (document != null) {
      document.status = DocumentStatus.released;
      document.releaseDate = DateTime.now();
    }
  }

  int getPendingCount() => getPending().length;

  int getTotalRequests() => _documents.length;

  Map<DocumentType, int> getRequestsPerType() {
    final map = <DocumentType, int>{};
    for (var doc in _documents) {
      map[doc.type] = (map[doc.type] ?? 0) + 1;
    }
    return map;
  }
}
