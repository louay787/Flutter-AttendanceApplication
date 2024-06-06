import 'package:flutter/material.dart';
import 'package:vsc/pages/util/notification.dart';

class NotificationCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          leading: Icon(Icons.notifications),
          title: Text(notification.title),
          subtitle: Text(notification.message),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete notification here
            },
          ),
        );
      },
    );
  }
}
