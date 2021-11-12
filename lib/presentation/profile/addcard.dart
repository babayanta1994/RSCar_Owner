import 'dart:collection';

import 'package:flutter/material.dart';

class AddingCardView extends StatefulWidget {
  AddingCardView({Key? key}) : super(key: key);
  String title = "Банковские реквизиты";
  @override
  _AddingCardState createState() => _AddingCardState();
}

class _AddingCardState extends State<AddingCardView> {
  var currentStep = 0;

  static TextEditingController controllerBankName = TextEditingController();
  static TextEditingController controllerRecNum = TextEditingController();
  static TextEditingController controllerInn = TextEditingController();
  static TextEditingController controllerKpp = TextEditingController();
  static TextEditingController controllerBik = TextEditingController();

  String? validator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Обязательное поле";
      }
    }
  }

  InputDecoration? decor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        maxLines: 1,
                        controller: controllerBankName,
                        decoration: InputDecoration(
                          label: Text("Название банка"),
                        ),
                        validator: validator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerRecNum,
                        decoration: InputDecoration(
                          label: Text("Номер счета"),
                        ),
                        validator: validator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerInn,
                        decoration: InputDecoration(
                          label: Text("ИНН банка"),
                        ),
                        validator: validator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerKpp,
                        decoration: InputDecoration(
                          label: Text("КПП"),
                        ),
                        validator: validator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerBik,
                        decoration: InputDecoration(
                          label: Text("БИК"),
                        ),
                        validator: validator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
