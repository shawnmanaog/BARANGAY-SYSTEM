import 'package:flutter/material.dart';
import '../models/document.dart';
import '../models/resident.dart';
import '../services/document_service.dart';
import '../services/resident_service.dart';
import '../widgets/request_document_dialog.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final DocumentService _service = DocumentService();
  final ResidentService _residentService = ResidentService();
  DocumentStatus? _selectedStatus;

  List<Document> get _filteredDocuments {
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
                  ...DocumentStatus.values.map((status) {
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
            child: _filteredDocuments.isEmpty
                ? const Center(child: Text('No documents'))
                : ListView.builder(
                    itemCount: _filteredDocuments.length,
                    itemBuilder: (context, index) {
                      final document = _filteredDocuments[index];
                      final resident = _residentService.getById(document.residentId);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.description),
                          title: Text(document.type.label),
                          subtitle: Text(
                            resident?.fullName ?? 'Unknown',
                          ),
                          trailing: Chip(
                            label: Text(document.status.label),
                            backgroundColor:
                                _getStatusColor(document.status),
                          ),
                          onTap: () {
                            _showDocumentDetails(context, document, resident);
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
            builder: (context) => RequestDocumentDialog(
              residents: _residentService.getAll(),
              onRequest: (residentId, type, purpose) {
                setState(() {
                  _service.requestDocument(residentId, type, purpose);
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDocumentDetails(
    BuildContext context,
    Document document,
    Resident? resident,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(document.type.label),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Resident:', resident?.fullName ?? 'Unknown'),
            _DetailRow('Purpose:', document.purpose),
            _DetailRow('Status:', document.status.label),
            _DetailRow(
              'Requested:',
              document.requestedDate.toString().split('.')[0],
            ),
            if (document.approvedDate != null)
              _DetailRow(
                'Approved:',
                document.approvedDate.toString().split('.')[0],
              ),
            if (document.notes != null)
              _DetailRow('Notes:', document.notes!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (document.status == DocumentStatus.pending)
            TextButton(
              onPressed: () {
                setState(() {
                  _service.approveDocument(document.id);
                });
                Navigator.pop(context);
              },
              child: const Text('Approve'),
            ),
          if (document.status == DocumentStatus.approved)
            TextButton(
              onPressed: () {
                setState(() {
                  _service.releaseDocument(document.id);
                });
                Navigator.pop(context);
              },
              child: const Text('Release'),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pending:
        return Colors.orange;
      case DocumentStatus.approved:
        return Colors.blue;
      case DocumentStatus.released:
        return Colors.green;
      case DocumentStatus.rejected:
        return Colors.red;
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Flexible(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
