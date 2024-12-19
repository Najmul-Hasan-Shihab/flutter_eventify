import 'package:flutter/material.dart';
class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> notifications = [
      'Event A is happening soon!',
      'Event B has been added to your saved list.',
      'Check out Event C near your location.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications, color: Colors.blue),
            title: Text(notifications[index]),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}