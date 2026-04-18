import 'package:flutter/material.dart';
import '../services/resident_service.dart';
import '../services/document_service.dart';
import '../services/complaint_service.dart';
import '../services/official_service.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final residentService = ResidentService();
    final documentService = DocumentService();
    final complaintService = ComplaintService();
    final officialService = OfficialService();

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                StatCard(
                  title: 'Total Residents',
                  value: residentService.getTotalResidents().toString(),
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                StatCard(
                  title: 'Verified Residents',
                  value: residentService.getVerifiedCount().toString(),
                  icon: Icons.verified_user,
                  color: Colors.green,
                ),
                StatCard(
                  title: 'Pending Documents',
                  value: documentService.getPendingCount().toString(),
                  icon: Icons.description,
                  color: Colors.orange,
                ),
                StatCard(
                  title: 'Total Complaints',
                  value: complaintService.getTotalComplaints().toString(),
                  icon: Icons.warning,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Officials',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            if (officialService.getActive().isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No officials added yet'),
              )
            else
              ...officialService.getActive().map((official) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(official.firstName[0]),
                    ),
                    title: Text(official.fullName),
                    subtitle: Text(official.position.label),
                  ),
                );
              }),
            const SizedBox(height: 16),
            Text(
              'Quick Stats',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Active Officials'),
                        Text(
                          officialService.getTotalOfficials().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Pending Complaints'),
                        Text(
                          complaintService.getPendingComplaints().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Resolved Complaints'),
                        Text(
                          complaintService.getResolvedComplaints().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
