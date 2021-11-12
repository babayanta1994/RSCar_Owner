import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/faq/faq.dart';

class FaqDetail extends StatefulWidget {
  @override
  _FaqDetailState createState() => _FaqDetailState();
}

class _FaqDetailState extends State<FaqDetail> {
  @override
  Widget build(BuildContext context) {
    final faq = ModalRoute.of(context)!.settings.arguments as Faq;

    return Scaffold(
      appBar: AppBar(
        title: Text(faq.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(faq.detail),
      ),
    );
  }
}
