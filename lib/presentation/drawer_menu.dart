import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/faq/faqs.dart';
import 'package:rs_car_owner/presentation/notifications/notifications.dart';
import 'package:rs_car_owner/presentation/otp/otp_login.dart';
import 'package:rs_car_owner/presentation/paid_services/paid_services.dart';
import 'package:rs_car_owner/presentation/rules/rules.dart';
import 'package:rs_car_owner/presentation/support/support_main.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenu createState() => _DrawerMenu();
}

class _DrawerMenu extends State<DrawerMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: double.infinity,
        color: Colors.blueAccent,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: Image.asset(
                  'assets/images/new_logo.png',
                  height: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person_rounded),
                      radius: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "admin@gmail.com",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Правила и соглашения",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Image.asset(
                  'assets/images/calendar.png',
                  height: 30,
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Rules()));
                },
              ),
              ListTile(
                title: Text(
                  "Уведомления",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Image.asset(
                  'assets/images/notification.png',
                  height: 25,
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Notifications()));
                },
              ),
              
              ListTile(
                title: Text(
                  "Платные услуги",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaidServices()));
                },
              ),
              ListTile(
                title: Text(
                  "FAQ",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.live_help,
                  color: Colors.white,
                  size: 30,
                ),
                onTap: () {
                 Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Faqs()));
                },
              ),
              ListTile(
                title: Text(
                  "Помощь и поддержка",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.phone_forwarded,
                  color: Colors.white,
                  size: 30,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return SupportZenDesk();
                  }));
                },
              ),
              ListTile(
                title: Text(
                  "Поделиться приложением",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                onTap: () {
                  print("TAP");
                },
              ),
              ListTile(
                title: Text(
                  "Выйти из аккаунта",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onTap: () async {
                  print("TAP");
                  final _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => OtpLogin()));
                },
              ),
            ]),
      ),
    );
  }
}
