import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuccessAdd extends StatefulWidget {
  @override
  _SuccessAddState createState() => _SuccessAddState();
}

class _SuccessAddState extends State<SuccessAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Заявка успешно отправлена!"),
            const SizedBox(height: 15),
            Icon(
              FontAwesomeIcons.check,
              size: 50,
              color: Colors.green,
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text("Заявка отправлена"),
        //backgroundColor: Color(0x00000000),
      ),
    );
  }
}
