import 'package:flutter/material.dart';
import '../models/resident.dart';
import '../services/resident_service.dart';
import '../widgets/add_resident_dialog.dart';

class ResidentsScreen extends StatefulWidget {
  const ResidentsScreen({Key? key}) : super(key: key);

  @override
  State<ResidentsScreen> createState() => _ResidentsScreenState();
}

class _ResidentsScreenState extends State<ResidentsScreen> {
  final ResidentService _service = ResidentService();
  String _searchQuery = '';

  List<Resident> get _filteredResidents {
    if (_searchQuery.isEmpty) {
      return _service.getAll();
    }
    return _service.searchByName(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              hintText: 'Search residents...',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: _filteredResidents.isEmpty
                ? Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? 'No residents yet'
                          : 'No results found',
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredResidents.length,
                    itemBuilder: (context, index) {
                      final resident = _filteredResidents[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(resident.firstName[0]),
                          ),
                          title: Text(resident.fullName),
                          subtitle: Text(resident.email),
                          trailing: resident.isVerified
                              ? const Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                )
                              : null,
                          onTap: () {
                            _showResidentDetails(context, resident);
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
            builder: (context) => AddResidentDialog(
              onSave: (firstName, lastName, email, phone, address, barangay,
                  dateOfBirth, gender, civilStatus) {
                setState(() {
                  _service.addResident(
                    firstName,
                    lastName,
                    email,
                    phone,
                    address,
                    barangay,
                    dateOfBirth,
                    gender,
                    civilStatus,
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

  void _showResidentDetails(BuildContext context, Resident resident) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(resident.fullName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Email:', resident.email),
            _DetailRow('Phone:', resident.phone),
            _DetailRow('Address:', resident.address),
            _DetailRow('Gender:', resident.gender),
            _DetailRow('Civil Status:', resident.civilStatus),
            _DetailRow('Verified:', resident.isVerified ? 'Yes' : 'No'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (!resident.isVerified)
            TextButton(
              onPressed: () {
                setState(() {
                  _service.verifyResident(resident.id);
                });
                Navigator.pop(context);
              },
              child: const Text('Verify'),
            ),
          TextButton(
            onPressed: () {
              setState(() {
                _service.deleteResident(resident.id);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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
