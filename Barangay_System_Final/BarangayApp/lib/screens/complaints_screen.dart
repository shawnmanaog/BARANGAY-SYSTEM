import 'package:flutter/material.dart';
import '../models/complaint.dart';
import '../models/resident.dart';
import '../services/complaint_service.dart';
import '../services/resident_service.dart';
import '../widgets/file_complaint_dialog.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  final ComplaintService _service = ComplaintService();
  final ResidentService _residentService = ResidentService();
  ComplaintStatus? _selectedStatus;

  List<Complaint> get _filteredComplaints {
    if (_selectedStatus == null) {
      return _service.getAll();
    }
    return _service.getByStatus(_selectedStatus!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: _selectedStatus == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedStatus = null;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ...ComplaintStatus.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(status.label),
                        selected: _selectedStatus == status,
                        onSelected: (selected) {
                          setState(() {
                            _selectedStatus = selected ? status : null;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Expanded(
            child: _filteredComplaints.isEmpty
                ? const Center(child: Text('No complaints'))
                : ListView.builder(
                    itemCount: _filteredComplaints.length,
                    itemBuilder: (context, index) {
                      final complaint = _filteredComplaints[index];
                      final resident = _residentService.getById(complaint.complainantId);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.warning_amber),
                          title: Text(complaint.respondentName),
                          subtitle: Text(
                            '${resident?.fullName ?? 'Unknown'} • ${complaint.category}',
                          ),
                          trailing: Chip(
                            label: Text(complaint.status.label),
                            backgroundColor:
                                _getStatusColor(complaint.status),
                          ),
                          onTap: () {
                            _showComplaintDetails(context, complaint, resident);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FileComplaintDialog(
              residents: _residentService.getAll(),
              onFile: (complainantId, respondentName, description, location,
                  category) {
                setState(() {
                  _service.fileComplaint(
                    complainantId,
                    respondentName,
                    description,
                    location,
                    category,
                  );
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showComplaintDetails(
    BuildContext context,
    Complaint complaint,
    Resident? resident,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(complaint.respondentName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Complainant:', resident?.fullName ?? 'Unknown'),
            _DetailRow('Category:', complaint.category),
            _DetailRow('Location:', complaint.location),
            _DetailRow('Description:', complaint.description),
            _DetailRow('Status:', complaint.status.label),
            _DetailRow(
              'Filed:',
              complaint.filedDate.toString().split('.')[0],
            ),
            if (complaint.resolutionNotes != null)
              _DetailRow('Resolution:', complaint.resolutionNotes!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (complaint.status == ComplaintStatus.filed)
            TextButton(
              onPressed: () {
                setState(() {
                  _service.startInvestigation(complaint.id);
                });
                Navigator.pop(context);
              },
              child: const Text('Investigate'),
            ),
          if (complaint.status == ComplaintStatus.investigating)
            TextButton(
              onPressed: () {
                _showResolutionDialog(context, complaint);
              },
              child: const Text('Resolve'),
            ),
        ],
      ),
    );
  }

  void _showResolutionDialog(BuildContext context, Complaint complaint) {
    final TextEditingController notesController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resolve Complaint'),
        content: TextField(
          controller: notesController,
          decoration: const InputDecoration(
            hintText: 'Resolution notes',
          ),
          maxLines: 4,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _service.resolveComplaint(complaint.id, notesController.text);
              });
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Resolve'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(ComplaintStatus status) {
    switch (status) {
      case ComplaintStatus.filed:
        return Colors.red;
      case ComplaintStatus.investigating:
        return Colors.orange;
      case ComplaintStatus.resolved:
        return Colors.green;
      case ComplaintStatus.closed:
        return Colors.grey;
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
