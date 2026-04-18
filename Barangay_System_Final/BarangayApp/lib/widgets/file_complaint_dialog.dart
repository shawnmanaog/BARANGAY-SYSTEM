import 'package:flutter/material.dart';
import '../models/resident.dart';

class FileComplaintDialog extends StatefulWidget {
  final List<Resident> residents;
  final Function(String, String, String, String, String) onFile;

  const FileComplaintDialog({
    Key? key,
    required this.residents,
    required this.onFile,
  }) : super(key: key);

  @override
  State<FileComplaintDialog> createState() => _FileComplaintDialogState();
}

class _FileComplaintDialogState extends State<FileComplaintDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _complainantId;
  late String _respondentName;
  late String _description;
  late String _location;
  late String _category;

  @override
  void initState() {
    super.initState();
    _complainantId = widget.residents.isNotEmpty
        ? widget.residents[0].id
        : '';
    _category = 'Disturbance';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('File Complaint'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _complainantId,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _complainantId = value ?? '');
                },
                items: widget.residents
                    .map((r) =>
                        DropdownMenuItem(value: r.id, child: Text(r.fullName)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Respondent Name'),
                onSaved: (value) => _respondentName = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (value) => _location = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              DropdownButton<String>(
                value: _category,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _category = value ?? 'Disturbance');
                },
                items: [
                  'Disturbance',
                  'Theft',
                  'Assault',
                  'Property Damage',
                  'Other',
                ]
                    .map((c) =>
                        DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
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
              widget.onFile(
                _complainantId,
                _respondentName,
                _description,
                _location,
                _category,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('File'),
        ),
      ],
    );
  }
}
