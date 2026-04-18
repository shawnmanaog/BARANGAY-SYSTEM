import 'package:flutter/material.dart';
import '../models/official.dart';
import '../services/official_service.dart';
import '../widgets/add_official_dialog.dart';

class OfficialsScreen extends StatefulWidget {
  const OfficialsScreen({Key? key}) : super(key: key);

  @override
  State<OfficialsScreen> createState() => _OfficialsScreenState();
}

class _OfficialsScreenState extends State<OfficialsScreen> {
  final OfficialService _service = OfficialService();

  @override
  Widget build(BuildContext context) {
    final officials = _service.getActive();

    return Scaffold(
      body: officials.isEmpty
          ? const Center(child: Text('No officials added yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: officials.length,
              itemBuilder: (context, index) {
                final official = officials[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(official.firstName[0]),
                    ),
                    title: Text(official.fullName),
                    subtitle: Text(official.position.label),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const Text('View Details'),
                          onTap: () {
                            Future.delayed(const Duration(seconds: 0), () {
                              _showOfficialDetails(context, official);
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: const Text('Deactivate'),
                          onTap: () {
                            setState(() {
                              _service.deactivateOfficial(official.id);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddOfficialDialog(
              onSave: (firstName, lastName, position, email, phone,
                  termStart, termEnd) {
                setState(() {
                  _service.addOfficial(
                    firstName,
                    lastName,
                    position,
                    email,
                    phone,
                    termStart,
                    termEnd,
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

  void _showOfficialDetails(BuildContext context, Official official) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(official.fullName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Position:', official.position.label),
            _DetailRow('Email:', official.email),
            _DetailRow('Phone:', official.phone),
            _DetailRow(
              'Term Start:',
              official.termStart.toString().split(' ')[0],
            ),
            _DetailRow(
              'Term End:',
              official.termEnd.toString().split(' ')[0],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
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
