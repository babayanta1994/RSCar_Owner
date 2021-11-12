import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/add_car/add_car_view.dart';
import 'package:rs_car_owner/presentation/notifications/detail_notification.dart';
import 'package:rs_car_owner/presentation/notifications/notification.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var notifications = [];

  getNotifications() {
    return List.generate(
      20,
      (i) => Notif(
        'Уведомдение ${i + 1}',
        'Сообщение уведомления ${i + 1}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    notifications = getNotifications();
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                _navigateToNotificationDetail(context, index);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(notifications[index].title),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToNotificationDetail(BuildContext context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetail(),
        settings: RouteSettings(
          arguments: notifications[index],
        ),
      ),
    );
  }
}
