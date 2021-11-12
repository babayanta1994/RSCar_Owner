import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/support/support_main.dart';
import 'package:flutter/services.dart';

class RegisterStep1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterStep1State();
  }
}

class RegisterStep1State extends State<RegisterStep1> {
  static final formKey = GlobalKey<FormState>();

  static TextEditingController controllerName = TextEditingController();
  static TextEditingController controllerPatronymic = TextEditingController();
  static TextEditingController controllerSurname = TextEditingController();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerPassword = TextEditingController();
  static TextEditingController controllerRepratPassword =
      TextEditingController();
  static bool checkedValue = false;

  bool _isObscure1 = true;
  bool _isObscure2 = true;

  String? validator(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
  }

  String? nameValidator(String? value) {
    if (value!.trim().isEmpty) {
      return "Введите имя";
    }
  }

  String? surNameValidator(String? value) {
    if (value!.trim().isEmpty) {
      return "Введите фамилию";
    }
  }

  String? emailValidator(String? value) {
    if (value!.length == 1) {
      return "Пожалуйста, введите корректный Email";
    }

    if (value.trim().isEmpty) {
      return "Введите Email";
    } else {
      RegExp exp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      Iterable<RegExpMatch> matches = exp.allMatches(value);
      if (matches.isEmpty) {
        return "Пожалуйста, введите корректный Email";
      }
    }
  }

  String? validatorPass(String? value) {
    if (value!.trim().isEmpty) {
      return "Введите пароль";
    }
    if (value.length < 5) {
      return "Минимальная длина пароля 5 символов";
    }
    if (value.length > 20) {
      return "Максимальная длина пароля 20 символов";
    }
    if (controllerPassword.text.compareTo(controllerRepratPassword.text) != 0) {
      return "Пароли не совпадают";
    }
  }

  String? validatorPassSec(String? value) {
    if (value!.trim().isEmpty) {
      return "Пароли не совпадают";
    }
    if (value.length < 5) {
      return "Минимальная длина пароля 5 символов";
    }
    if (value.length > 20) {
      return "Максимальная длина пароля 20 символов";
    }
    if (controllerPassword.text.compareTo(controllerRepratPassword.text) != 0) {
      return "Пароли не совпадают";
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
        children: <Widget>[
          Text(
            "Создайте новый аккаунт",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerName,
            decoration: decor().copyWith(
                labelText: "Имя", prefixIcon: const Icon(Icons.person)),
            validator: nameValidator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-zА-Яа-я]')),
              LengthLimitingTextInputFormatter(256)
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 1,
            controller: controllerPatronymic,
            decoration: decor().copyWith(
                labelText: "Отчество", prefixIcon: const Icon(Icons.person)),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-zА-Яа-я]')),
              LengthLimitingTextInputFormatter(256)
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerSurname,
            decoration: decor().copyWith(
                labelText: "Фамилия", prefixIcon: const Icon(Icons.person)),
            validator: surNameValidator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-zА-Яа-я]')),
              LengthLimitingTextInputFormatter(256)
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            controller: controllerEmail,
            decoration: decor().copyWith(
                labelText: "Email", prefixIcon: const Icon(Icons.email)),
            validator: emailValidator,
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            obscureText: _isObscure1,
            controller: controllerPassword,
            decoration: decor().copyWith(
              labelText: "Пароль",
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure1 ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure1 = !_isObscure1;
                  });
                },
              ),
            ),
            validator: validatorPass,
          ),
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 1,
            obscureText: _isObscure2,
            controller: controllerRepratPassword,
            decoration: decor().copyWith(
              labelText: "Повторите пароль",
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure2 ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure2 = !_isObscure2;
                  });
                },
              ),
            ),
            validator: validatorPassSec,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("Добавить статус руководителя"),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue ?? false;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              IconButton(
                onPressed: () {
                  final snackBar = SnackBar(
                    duration: Duration(days: 1),
                    content: const Text(
                        'При нажатии чек-бокса "Добавить статус руководителя" у Вас появляется возможность зарегистрировать Ваше юридическое лицо или ИП и создать личный кабинет юридического лица (Индивидуального предпринимателя)'),
                    action: SnackBarAction(
                      label: 'Закрыть',
                      onPressed: () {},
                    ),
                  );

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.lightBlue,
                ),
              ),
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
