import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/faq/detail_faq.dart';
import 'package:rs_car_owner/presentation/faq/faq.dart';

class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  var faqs = [];

  getFaqs() {
    return List.generate(
      20,
      (i) => Faq(
        'FAQ №${i + 1}',
        'Текст вопроса FAQ ${i + 1}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    faqs = getFaqs();
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                _navigateToFaqDetail(context, index);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(faqs[index].title),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToFaqDetail(BuildContext context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FaqDetail(),
        settings: RouteSettings(
          arguments: faqs[index],
        ),
      ),
    );
  }
}
