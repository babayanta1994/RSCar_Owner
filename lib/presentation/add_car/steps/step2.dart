import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Step2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Step2State();
  }
}

class Step2State extends State<Step2> {
  static final formKey = GlobalKey<FormState>();
  String? validator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Обязательное поле";
      }
    }
  }

  String? validatorVIN(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
    if (value.length != 17) {
      return "Необходимое количество символов в поле - 17";
    }
  }

  InputDecoration? decor() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      errorMaxLines: 2,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  BoxConstraints constr(int a) {
    return BoxConstraints(
        minHeight: 38, minWidth: (MediaQuery.of(context).size.width - 54) / a);
  }

  static TextEditingController controllerMile = TextEditingController();
  static TextEditingController controllerVIN = TextEditingController();
  static var transmission = ["Автоматическая", "Ручная"];
  static var transmissionInd = [true, false];
  static var yesNo = ["Да", "Нет"];
  static var childInd = [true, false];
  static var animalInd = [true, false];
  static var luxInd = [true, false];
  static var places = ["2 места", "4 места", "5-7 мест"];
  static var placesInd = [true, false, false];
  static var fuel = ["Бензин", "Дизель", "Электро"];
  static var fuelInd = [true, false, false];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).viewInsets.bottom + kToolbarHeight + 180),
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Пробег'),
                  const SizedBox(height: 5),
                  TextFormField(
                    maxLines: 1,
                    controller: controllerMile,
                    decoration: decor()!.copyWith(
                        hintText: "Введите пробег в километрах",
                        hintMaxLines: 2,
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    validator: validator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Идентификационный номер (VIN)'),
                  const SizedBox(height: 5),
                  TextFormField(
                    maxLines: 1,
                    controller: controllerVIN,
                    decoration: decor()!.copyWith(
                        hintText: "Введите идентификационный (VIN) номер",
                        hintMaxLines: 2,
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    validator: validatorVIN,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                      LengthLimitingTextInputFormatter(17)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Трансмиссия'),
                  const SizedBox(height: 5),
                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      constraints: constr(transmissionInd.length),
                      children: transmission.map((e) => Text(e)).toList(),
                      isSelected: transmissionInd,
                      onPressed: (int index) {
                        setState(() {
                          transmissionInd.asMap().forEach((ind, element) {
                            transmissionInd[ind] =
                                ((ind == index) ? true : false);
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Детское кресло есть?'),
                  const SizedBox(height: 5),
                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      constraints: constr(childInd.length),
                      children: yesNo.map((e) => Text(e)).toList(),
                      isSelected: childInd,
                      onPressed: (int index) {
                        setState(() {
                          childInd.asMap().forEach((ind, element) {
                            childInd[ind] = ((ind == index) ? true : false);
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('С животными можно?'),
                  const SizedBox(height: 5),
                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      constraints: constr(animalInd.length),
                      children: yesNo.map((e) => Text(e)).toList(),
                      isSelected: animalInd,
                      onPressed: (int index) {
                        setState(() {
                          animalInd.asMap().forEach((ind, element) {
                            animalInd[ind] = ((ind == index) ? true : false);
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Люк в крыше есть?'),
                  const SizedBox(height: 5),
                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      constraints: constr(luxInd.length),
                      children: yesNo.map((e) => Text(e)).toList(),
                      isSelected: luxInd,
                      onPressed: (int index) {
                        setState(() {
                          luxInd.asMap().forEach((ind, element) {
                            luxInd[ind] = ((ind == index) ? true : false);
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Сколько мест?'),
                  const SizedBox(height: 5),
                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      constraints: constr(places.length),
                      children: places.map((e) => Text(e)).toList(),
                      isSelected: placesInd,
                      onPressed: (int index) {
                        setState(() {
                          placesInd.asMap().forEach((ind, element) {
                            placesInd[ind] = ((ind == index) ? true : false);
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Вид топлива'),
                  const SizedBox(height: 5),
                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      constraints: constr(placesInd.length),
                      children: fuel.map((e) => Text(e)).toList(),
                      isSelected: fuelInd,
                      onPressed: (int index) {
                        setState(() {
                          fuelInd.asMap().forEach((ind, element) {
                            fuelInd[ind] = ((ind == index) ? true : false);
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
