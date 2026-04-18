enum ComplaintStatus {
  filed('Filed'),
  investigating('Investigating'),
  resolved('Resolved'),
  closed('Closed');

  final String label;
  const ComplaintStatus(this.label);
}

class Complaint {
  final String id;
  final String complainantId;
  final String respondentName;
  final String description;
  final String location;
  ComplaintStatus status;
  final DateTime filedDate;
  DateTime? resolvedDate;
  String? resolutionNotes;
  final String category;

  Complaint({
    required this.id,
    required this.complainantId,
    required this.respondentName,
    required this.description,
    required this.location,
    required this.status,
    required this.filedDate,
    this.resolvedDate,
    this.resolutionNotes,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'complainantId': complainantId,
      'respondentName': respondentName,
      'description': description,
      'location': location,
      'status': status.name,
      'filedDate': filedDate.toIso8601String(),
      'resolvedDate': resolvedDate?.toIso8601String(),
      'resolutionNotes': resolutionNotes,
      'category': category,
    };
  }

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      complainantId: json['complainantId'],
      respondentName: json['respondentName'],
      description: json['description'],
      location: json['location'],
      status: ComplaintStatus.values.byName(json['status']),
      filedDate: DateTime.parse(json['filedDate']),
      resolvedDate: json['resolvedDate'] != null ? DateTime.parse(json['resolvedDate']) : null,
      resolutionNotes: json['resolutionNotes'],
      category: json['category'],
    );
  }
}
