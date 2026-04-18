import 'package:flutter/material.dart';
import '../models/official.dart';

class AddOfficialDialog extends StatefulWidget {
  final Function(String, String, Position, String, String, DateTime, DateTime)
      onSave;

  const AddOfficialDialog({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddOfficialDialog> createState() => _AddOfficialDialogState();
}

class _AddOfficialDialogState extends State<AddOfficialDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late Position _position;
  late DateTime _termStart;
  late DateTime _termEnd;

  @override
  void initState() {
    super.initState();
    _position = Position.kagawad;
    _termStart = DateTime.now();
    _termEnd = DateTime.now().add(const Duration(days: 365 * 3));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Official'),
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
              const SizedBox(height: 16),
              DropdownButton<Position>(
                value: _position,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _position = value ?? Position.kagawad);
                },
                items: Position.values
                    .map((p) =>
                        DropdownMenuItem(value: p, child: Text(p.label)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Term Start'),
                subtitle: Text(_termStart.toString().split(' ')[0]),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _termStart,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => _termStart = date);
                  }
                },
              ),
              ListTile(
                title: const Text('Term End'),
                subtitle: Text(_termEnd.toString().split(' ')[0]),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _termEnd,
                    firstDate: _termStart,
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() => _termEnd = date);
                  }
                },
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
                _position,
                _email,
                _phone,
                _termStart,
                _termEnd,
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
