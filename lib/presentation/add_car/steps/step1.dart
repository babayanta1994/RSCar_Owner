import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
// import 'package:numberpicker/numberpicker.dart';

class CarNumberEnter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    var textSel = TextSelection(
        baseOffset: newValue.selection.baseOffset,
        extentOffset: newValue.selection.extentOffset,
        affinity: newValue.selection.affinity,
        isDirectional: newValue.selection.isDirectional);
    if (oldValue.text.endsWith(" ") &&
        newValue.text.length < oldValue.text.length) {
      newText = newValue.text.substring(0, newValue.text.length - 1);
      textSel = TextSelection(
          baseOffset: newText.length,
          extentOffset: newText.length,
          affinity: newValue.selection.affinity,
          isDirectional: newValue.selection.isDirectional);
    }
    if (newText.length == 1 && !oldValue.text.endsWith(" ")) {
      newText += " ";
      textSel = TextSelection(
          baseOffset: 2,
          extentOffset: 2,
          affinity: newValue.selection.affinity,
          isDirectional: newValue.selection.isDirectional);
    }
    if (newText.length == 5 && !oldValue.text.endsWith(" ")) {
      newText += " ";
      textSel = TextSelection(
          baseOffset: 6,
          extentOffset: 6,
          affinity: newValue.selection.affinity,
          isDirectional: newValue.selection.isDirectional);
    }
    return TextEditingValue(
      text: newText,
      selection: textSel,
    );
  }
}

class Step1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Step1State();
  }
}

class Step1State extends State<Step1> {
  var keybVal = true;
  static final formKey = GlobalKey<FormState>();

  List<String> _carsBrand = [
    '',
    'Audi',
    'BMW',
    'Mercedes',
    'Hundai',
    'Kia',
    'Lada'
  ];

  List<String> _carsColor = [
    '',
    'Красный',
    'Синий',
    'Желтый',
    'Белый',
    'Черный',
    'Фиолетовый'
  ];

  List<String> _carsCountry = [
    '',
    'США',
    'Россия',
    'Китай',
    'Германия',
    'Франция',
    'Италия'
  ];

  List<String> _carsCity = [
    '',
    'Санкт-Петербург',
    'Москва',
    'Краснадар',
    'Калуга',
    'Калининград',
    'Оренбург'
  ];

  List<String> _carsModel = ['', 'X7', 'M3', 'SLS'];

  static String selectedBrand = "";
  static String selectedModel = "";
  static String selectedColor = "";
  static String selectedCity = "";
  static String selectedCountry = "";
  static int selectedYear = DateTime.now().year;
  static TextEditingController controllerCategory = new TextEditingController();

  static TextEditingController controllerNumber1 = new TextEditingController();
  static TextEditingController controllerNumber2 = new TextEditingController();
  static TextEditingController controllerNumber3 = new TextEditingController();
  static TextEditingController controllerNumber4 = new TextEditingController();

  String? validator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Обязательное поле";
      }
    }
  }

  String? validatorBrend(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Выберите бренд";
      }
    }
  }

  String? validatorModel(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Выберите модель";
      }
    }
  }

  String? validatorColor(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Выберите цвет";
      }
    }
  }

  String? validatorCountry(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Выберите страну";
      }
    }
  }

  String? validatorCity(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Выберите город";
      }
    }
  }

  String? numFValidator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Обязательное поле";
      }

      if (value.length < 8) {
        return "Обязательное поле";
      }
    }
  }

  String? numSValidator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Обязательное поле";
      }
      if (value.length < 2) {
        return "Обязательное поле";
      }
    }
  }

  InputDecoration? decorText() {
    return const InputDecoration(
      filled: true,
      isDense: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  InputDecoration? decorDrop() {
    return const InputDecoration(
      filled: true,
      isDense: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  InputDecoration? decorN1() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  InputDecoration? decorN2() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  InputDecoration? decorN3() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  InputDecoration? decorN4() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  Decoration? decorPiker() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black),
    );
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Бренд'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: decorDrop(),
                    items: _carsBrand
                        .map((car) => DropdownMenuItem(
                              child: new Text(car),
                              value: car,
                            ))
                        .toList(),
                    validator: validatorBrend,
                    value: selectedBrand,
                    onChanged: (value) =>
                        setState(() => selectedBrand = value as String),
                  ),
                  const SizedBox(height: 10),
                  Text('Модель'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: decorDrop(),
                    items: selectedBrand.isNotEmpty
                        ? _carsModel
                            .map((car) => DropdownMenuItem(
                                  child: new Text(car),
                                  value: car,
                                ))
                            .toList()
                        : null,
                    validator: validatorModel,
                    value: selectedModel,
                    onChanged: (value) =>
                        setState(() => selectedModel = value as String),
                  ),
                  const SizedBox(height: 10),
                  Text('Категория'),
                  const SizedBox(height: 5),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    controller: controllerCategory,
                    decoration: decorText(),
                    validator: validator,
                  ),
                  const SizedBox(height: 10),
                  Text('Год выпуска'),
                  const SizedBox(height: 5),
                  Container(
                    decoration: decorPiker(),
                    child: Center(
                      heightFactor: 0.28,
                      child: HorizontalPicker(
                        minValue: DateTime.now().year - 100,
                        maxValue: DateTime.now().year + 0,
                        initialPosition: InitialPosition.end,
                        divisions: 100,
                        showCursor: false,
                        backgroundColor: Colors.transparent,
                        activeItemTextColor: Colors.blueAccent,
                        passiveItemsTextColor: Colors.blueGrey,
                        cursorColor: Colors.cyan,
                        onChanged: (value) {
                          selectedYear = value.toInt();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Цвет'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: decorDrop(),
                    items: _carsColor
                        .map((car) => DropdownMenuItem(
                              child: new Text(car),
                              value: car,
                            ))
                        .toList(),
                    validator: validatorColor,
                    value: selectedColor,
                    onChanged: (value) =>
                        setState(() => selectedColor = value as String),
                  ),
                  const SizedBox(height: 10),
                  Text('Страна'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: decorDrop(),
                    items: _carsCountry
                        .map((car) => DropdownMenuItem(
                              child: new Text(car),
                              value: car,
                            ))
                        .toList(),
                    validator: validatorCountry,
                    value: selectedCountry,
                    onChanged: (value) =>
                        setState(() => selectedCountry = value as String),
                  ),
                  const SizedBox(height: 10),
                  Text('Город'),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: decorDrop(),
                    items: _carsCity
                        .map((car) => DropdownMenuItem(
                              child: new Text(car),
                              value: car,
                            ))
                        .toList(),
                    validator: validatorCity,
                    value: selectedCity,
                    onChanged: selectedCountry == ""
                        ? null
                        : (value) =>
                            setState(() => selectedCity = value as String),
                  ),
                  const SizedBox(height: 10),
                  Text('Государственный номер'),
                  const SizedBox(height: 5),
                  Padding(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              controller: controllerNumber1,
                              keyboardType: keybVal
                                  ? TextInputType.text
                                  : TextInputType.text,
                              decoration: decorN1(),
                              validator: numFValidator,
                              inputFormatters: [
                                CarNumberEnter(),
                                LengthLimitingTextInputFormatter(8)
                              ],
                              onChanged: (value) => {
                                if (value.length > 2 || value.length < 5)
                                  {
                                    setState(() => {keybVal = false})
                                  }
                                else
                                  {
                                    setState(() => {keybVal = true})
                                  }
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: controllerNumber2,
                            decoration: decorN2(),
                            validator: numSValidator,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(bottom: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
