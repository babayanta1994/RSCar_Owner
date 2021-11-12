import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/add_car/add_car_view.dart';
import 'package:rs_car_owner/presentation/rules/rule.dart';

class RuleDetail extends StatefulWidget {
  @override
  _RuleDetailState createState() => _RuleDetailState();
}

class _RuleDetailState extends State<RuleDetail> {
  @override
  Widget build(BuildContext context) {
    final rule = ModalRoute.of(context)!.settings.arguments as Rule;

    return Scaffold(
      appBar: AppBar(
        title: Text(rule.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(rule.detail),
      ),
    );
  }
}
