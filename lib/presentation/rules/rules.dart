import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/add_car/add_car_view.dart';
import 'package:rs_car_owner/presentation/rules/detail_rule.dart';
import 'package:rs_car_owner/presentation/rules/rule.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  var rules = [];

  getRules() {
    return List.generate(
      20,
      (i) => Rule(
        'Правило/соглашение №${i + 1}',
        'Подробная информация и документ Правила/соглашения №${i + 1}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    rules = getRules();
    return Scaffold(
      appBar: AppBar(
        title: Text('Правила и соглашения'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        itemCount: rules.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                _navigateToRuleDetail(context, index);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(rules[index].title),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToRuleDetail(BuildContext context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RuleDetail(),
        settings: RouteSettings(
          arguments: rules[index],
        ),
      ),
    );
  }
}
