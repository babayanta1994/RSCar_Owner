import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/cars/cars_view.dart';
import 'package:rs_car_owner/presentation/my_flutter_app_icons.dart';
import 'package:rs_car_owner/presentation/profile/profile.dart';
import '../presentation/google_maps.dart';

class TabItem {
  String title;
  Icon icon;
  TabItem({required this.title, required this.icon});
}

final List<TabItem> _tabBar = [
  TabItem(title: "Мои авто", icon: Icon(MyFlutterApp.my_cars_nav)),
  TabItem(title: "Автопарк", icon: Icon(MyFlutterApp.fleet_icon_nav)),
  TabItem(title: "Поездки", icon: Icon(MyFlutterApp.orders_icon_nav)),
  TabItem(title: "Профиль", icon: Icon(Icons.person))
];

class BottomNavigationTapBar extends StatefulWidget {
  const BottomNavigationTapBar({Key? key}) : super(key: key);

  @override
  _BottomNavigationTapBarState createState() => _BottomNavigationTapBarState();
}

class _BottomNavigationTapBarState extends State<BottomNavigationTapBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBar.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              GoogleView(),
              CarsView(),
              Container(color: Colors.blue, child: Center(child: Text("3"))),
              ProfileView(),
            ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _tabController?.index = index;
              _currentTabIndex = index;
            });
          },
          currentIndex: _currentTabIndex,
          items: [
            for (final item in _tabBar)
              BottomNavigationBarItem(
                  icon: item.icon,
                  label: item.title,
                  backgroundColor: Colors.black)
          ],
        ));
  }
}
