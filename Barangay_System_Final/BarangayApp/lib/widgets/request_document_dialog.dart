import 'package:flutter/material.dart';
import '../models/resident.dart';
import '../models/document.dart';

class RequestDocumentDialog extends StatefulWidget {
  final List<Resident> residents;
  final Function(String, DocumentType, String) onRequest;

  const RequestDocumentDialog({
    Key? key,
    required this.residents,
    required this.onRequest,
  }) : super(key: key);

  @override
  State<RequestDocumentDialog> createState() => _RequestDocumentDialogState();
}

class _RequestDocumentDialogState extends State<RequestDocumentDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedResidentId;
  late DocumentType _selectedType;
  late String _purpose;

  @override
  void initState() {
    super.initState();
    _selectedResidentId = widget.residents.isNotEmpty
        ? widget.residents[0].id
        : '';
    _selectedType = DocumentType.barangayClearance;
    _purpose = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Request Document'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedResidentId,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _selectedResidentId = value ?? '');
                },
                items: widget.residents
                    .map((r) =>
                        DropdownMenuItem(value: r.id, child: Text(r.fullName)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              DropdownButton<DocumentType>(
                value: _selectedType,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _selectedType = value ?? DocumentType.barangayClearance);
                },
                items: DocumentType.values
                    .map((t) =>
                        DropdownMenuItem(value: t, child: Text(t.label)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Purpose'),
                onSaved: (value) => _purpose = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onRequest(_selectedResidentId, _selectedType, _purpose);
              Navigator.pop(context);
            }
          },
          child: const Text('Request'),
        ),
      ],
    );
  }
}
