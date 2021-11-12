import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter/services.dart';
import 'package:rs_car_owner/presentation/support/support_main.dart';

class RegisterStep2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterStep2State();
  }
}

class RegisterStep2State extends State<RegisterStep2> {
  static final formKey = GlobalKey<FormState>();

  static String groupStatus = "ООО";
  List<String> valsStatus = ["ООО", "ИП"];

  static String groupNds = "Да";
  List<String> valsNds = ["Да", "Нет"];

  static TextEditingController controllerFullName = TextEditingController();
  static TextEditingController controllerOgrn = TextEditingController();
  static TextEditingController controllerInn = TextEditingController();
  static TextEditingController controllerManageStatus = TextEditingController();
  static TextEditingController controllerFioManager = TextEditingController();
  static TextEditingController controllerInnManager = TextEditingController();
  static TextEditingController controllerPhone = TextEditingController();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerContactInfo = TextEditingController();

  String? validator(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
  }

  String? fullNameValidator(String? value) {
    if (value!.trim().isEmpty) {
      return "Введите полное наименование компании";
    }
  }

  String? innValidator(String? value) {
    if (groupStatus == "ООО" && (value!.length < 10 || value.length > 10)) {
      return "Пожалуйста ведите корректный ИНН";
    }
    if (groupStatus == "ИП" && value!.length < 12) {
      return "Пожалуйста ведите корректный ИНН";
    }

    if (value!.trim().isEmpty) {
      return "Введите ИНН";
    }
  }

  String? innEmailValidator(String? value) {
    if (value!.length == 1) {
      return "Пожалуйста, введите корректный адрес электронной почты организации";
    }
    if (value.trim().isEmpty) {
      return "Введите адрес электронной почты организации";
    }
    RegExp exp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    Iterable<RegExpMatch> matches = exp.allMatches(value);
    if (matches.isEmpty) {
      return "Пожалуйста, введите корректный адрес электронной почты организации";
    }
  }

  String? emailValidator(String? value) {
    if (value!.length == 1) {
      return "Пожалуйста, введите корректный служебный адрес электронной почты";
    }
    if (value.trim().isEmpty) {
      return "Введите служебный адрес электронной почты";
    }
    RegExp exp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    Iterable<RegExpMatch> matches = exp.allMatches(value);
    if (matches.isEmpty) {
      return "Пожалуйста, введите корректный служебный адрес электронной почты";
    }
  }

  String? ogrnValidator(String? value) {
    if (groupStatus == "ООО" && (value!.length < 13 || value.length > 13)) {
      return "Пожалуйста ведите корректный ОГРН";
    }
    if (groupStatus == "ИП" && value!.length < 15) {
      return "Пожалуйста ведите корректный ОГРН";
    }
    if (value!.trim().isEmpty) {
      return "Введите ОГРН";
    }
  }

  String? phoneValidator(String? value) {
    if (value!.length == 1) {
      return "Пожалуйста введите корректный служебный телефон";
    }
    if (value.length < 12) {
      return "Пожалуйста введите корректный служебный телефон";
    }

    if (value.trim().isEmpty) {
      return "Введите служебный телефон";
    }
  }

  InputDecoration decor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Реквизиты",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text("Правовой статус"),
          const SizedBox(height: 5),
          RadioGroup<String>.builder(
            direction: Axis.horizontal,
            groupValue: groupStatus,
            spacebetween: 1,
            horizontalAlignment: MainAxisAlignment.start,
            onChanged: (value) => setState(() {
              groupStatus = value!;
            }),
            items: valsStatus,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerFullName,
            decoration: decor().copyWith(
                labelStyle: TextStyle(fontSize: 12),
                label: Text("Полное наименование")),
            validator: fullNameValidator,
            inputFormatters: [LengthLimitingTextInputFormatter(256)],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerOgrn,
            decoration: decor().copyWith(
                labelStyle: TextStyle(fontSize: 12),
                label: Text("ОГРН (ОГРНИП - для ИП)")),
            validator: ogrnValidator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              groupStatus == "ООО"
                  ? LengthLimitingTextInputFormatter(13)
                  : LengthLimitingTextInputFormatter(15)
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerInn,
            decoration: decor().copyWith(
              labelStyle: TextStyle(fontSize: 12),
              label: Text(
                  "ИНН юридического лица (ИНН физического лица, зарегистрированного в качестве ИП)"),
            ),
            validator: innValidator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              groupStatus == "ООО"
                  ? LengthLimitingTextInputFormatter(10)
                  : LengthLimitingTextInputFormatter(12)
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 1,
            controller: controllerManageStatus,
            decoration: decor().copyWith(
              labelStyle: TextStyle(fontSize: 12),
              label: Text("Должность руководителя * (данные из ЕГРЮЛ)"),
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(256)],
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 1,
            controller: controllerFioManager,
            decoration: decor().copyWith(
                labelStyle: TextStyle(fontSize: 12),
                label: Text("ФИО руководителя *")),
            inputFormatters: [LengthLimitingTextInputFormatter(256)],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerInnManager,
            decoration: decor().copyWith(
              labelStyle: TextStyle(fontSize: 12),
              label: Text("ИНН руководителя (ИП) как физического лица"),
            ),
            validator: innValidator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(12)
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerPhone,
            decoration: decor().copyWith(
                labelStyle: TextStyle(fontSize: 12),
                label: Text("Служебный телефон")),
            validator: phoneValidator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
              LengthLimitingTextInputFormatter(15)
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerEmail,
            decoration: decor().copyWith(
                labelStyle: TextStyle(fontSize: 12),
                label: Text("Служебный адрес электронной почты")),
            validator: emailValidator,
            inputFormatters: [LengthLimitingTextInputFormatter(256)],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerContactInfo,
            decoration: decor().copyWith(
              labelStyle: TextStyle(fontSize: 12),
              label: Text(
                  "Контактная информация: адрес электронной почты организации (ИП)"),
            ),
            validator: innEmailValidator,
            inputFormatters: [LengthLimitingTextInputFormatter(256)],
          ),
          const SizedBox(height: 10),
          Text("Плательщик НДС"),
          const SizedBox(height: 5),
          RadioGroup<String>.builder(
            direction: Axis.horizontal,
            groupValue: groupNds,
            spacebetween: 1,
            horizontalAlignment: MainAxisAlignment.start,
            onChanged: (value) => setState(() {
              groupNds = value!;
            }),
            items: valsNds,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
            ),
          ),
          Text("* только для организаций"),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.live_help,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Нужна помощь?",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                    side: BorderSide(color: Colors.blue.shade900),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return SupportZenDesk();
                }));
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ));
  }
}
