import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/alert_model.dart';
import '../map/live_tracking_screen.dart';

class PoliceDashboard extends StatelessWidget {
  const PoliceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Police Dashboard - Active Alerts')),
      body: StreamBuilder<List<AlertModel>>(
        stream: firestoreService.getActiveAlerts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No active alerts.'));
          }

          final alerts = snapshot.data!;

          return ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Card(
                color: Colors.red[50],
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red, size: 40),
                  title: Text(alert.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Location: ${alert.latitude}, ${alert.longitude}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveTrackingScreen(alert: alert),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
