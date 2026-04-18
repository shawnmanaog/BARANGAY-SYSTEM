enum DocumentType {
  barangayClearance('Barangay Clearance'),
  certificateOfResidency('Certificate of Residency'),
  certOfIndigency('Certificate of Indigency'),
  businessClearance('Business Clearance'),
  firstTime('First Time Job Seeker'),
  soloParent('Solo Parent ID'),
  kcpe('KCPE Certificate'),
  pwdId('PWD ID');

  final String label;
  const DocumentType(this.label);
}

enum DocumentStatus {
  pending('Pending'),
  approved('Approved'),
  rejected('Rejected'),
  released('Released');

  final String label;
  const DocumentStatus(this.label);
}

class Document {
  final String id;
  final String residentId;
  final DocumentType type;
  DocumentStatus status;
  final DateTime requestedDate;
  DateTime? approvedDate;
  DateTime? releaseDate;
  final String purpose;
  String? notes;

  Document({
    required this.id,
    required this.residentId,
    required this.type,
    required this.status,
    required this.requestedDate,
    this.approvedDate,
    this.releaseDate,
    required this.purpose,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'residentId': residentId,
      'type': type.name,
      'status': status.name,
      'requestedDate': requestedDate.toIso8601String(),
      'approvedDate': approvedDate?.toIso8601String(),
      'releaseDate': releaseDate?.toIso8601String(),
      'purpose': purpose,
      'notes': notes,
    };
  }

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      residentId: json['residentId'],
      type: DocumentType.values.byName(json['type']),
      status: DocumentStatus.values.byName(json['status']),
      requestedDate: DateTime.parse(json['requestedDate']),
      approvedDate: json['approvedDate'] != null ? DateTime.parse(json['approvedDate']) : null,
      releaseDate: json['releaseDate'] != null ? DateTime.parse(json['releaseDate']) : null,
      purpose: json['purpose'],
      notes: json['notes'],
    );
  }
}
