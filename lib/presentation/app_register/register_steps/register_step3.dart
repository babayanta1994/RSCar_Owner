import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:rs_car_owner/presentation/support/support_main.dart';

class RegisterStep3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterStep3State();
  }
}

class RegisterStep3State extends State<RegisterStep3> {
  static final formKey = GlobalKey<FormState>();

  static TextEditingController controllerBankName = TextEditingController();
  static TextEditingController controllerRecNum = TextEditingController();
  static TextEditingController controllerInn = TextEditingController();
  static TextEditingController controllerKpp = TextEditingController();
  static TextEditingController controllerBik = TextEditingController();

  String? validator(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
  }

  String? validatorNS(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
    if (value.length != 20) {
      return "Необходимое количество символов в поле - 20";
    }
  }

  String? validatorInn(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
    if (value.length != 10 && value.length != 12) {
      return "Необходимое количество символов в поле - 10 или 12";
    }
  }

  String? validatorBik(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
    if (value.length != 9) {
      return "Необходимое количество символов в поле - 9";
    }
  }

  InputDecoration decor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      errorMaxLines: 2,
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
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerRecNum,
            decoration: InputDecoration(
              label: Text("Номер счета"),
            ),
            validator: validatorNS,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(20)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerInn,
            decoration: InputDecoration(
              label: Text("ИНН банка"),
            ),
            validator: validatorInn,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerKpp,
            decoration: InputDecoration(
              label: Text("КПП"),
            ),
            validator: validatorBik,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField( 
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerBik,
            decoration: InputDecoration(
              label: Text("БИК"),
            ),
            validator: validatorBik,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9)
            ],
          ),
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
