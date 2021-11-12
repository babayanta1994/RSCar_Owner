import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/add_car/add_car_view.dart';

class CarsView extends StatefulWidget {
  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<CarsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Нет машин",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_navigateToAddCarView(context)},
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddCarView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddCarView()));
  }
}
