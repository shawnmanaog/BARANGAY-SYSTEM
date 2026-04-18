import 'package:flutter/material.dart';

class AddResidentDialog extends StatefulWidget {
  final Function(String, String, String, String, String, String, DateTime,
      String, String) onSave;

  const AddResidentDialog({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddResidentDialog> createState() => _AddResidentDialogState();
}

class _AddResidentDialogState extends State<AddResidentDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late String _address;
  late String _barangay;
  late DateTime _dateOfBirth;
  late String _gender;
  late String _civilStatus;

  @override
  void initState() {
    super.initState();
    _dateOfBirth = DateTime.now();
    _gender = 'Male';
    _civilStatus = 'Single';
    _barangay = 'Barangay 1';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Resident'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (value) => _firstName = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => _lastName = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phone = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onSaved: (value) => _address = value ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              DropdownButton<String>(
                value: _barangay,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _barangay = value ?? 'Barangay 1');
                },
                items: [
                  'Barangay 1',
                  'Barangay 2',
                  'Barangay 3',
                  'Barangay 4',
                  'Barangay 5',
                ]
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
              ),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('Date of Birth'),
                subtitle: Text(_dateOfBirth.toString().split(' ')[0]),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dateOfBirth,
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => _dateOfBirth = date);
                  }
                },
              ),
              DropdownButton<String>(
                value: _gender,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _gender = value ?? 'Male');
                },
                items: ['Male', 'Female', 'Other']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _civilStatus,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _civilStatus = value ?? 'Single');
                },
                items: [
                  'Single',
                  'Married',
                  'Divorced',
                  'Widowed',
                ]
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
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
              widget.onSave(
                _firstName,
                _lastName,
                _email,
                _phone,
                _address,
                _barangay,
                _dateOfBirth,
                _gender,
                _civilStatus,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
