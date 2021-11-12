import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/add_car/add_car_view.dart';
import 'package:rs_car_owner/presentation/notifications/notification.dart';

class NotificationDetail extends StatefulWidget {
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    final notification = ModalRoute.of(context)!.settings.arguments as Notif;

    return Scaffold(
      appBar: AppBar(
        title: Text(notification.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(notification.detail),
      ),
    );
  }
}
