import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class Step3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Step3State();
  }
}

class Step3State extends State<Step3> {
  static final formKey = GlobalKey<FormState>();
  String? validator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Обязательное поле";
      }
    }
  }

  String? validatorNum(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
    if (value.length < 3) {
      return "Минимум 3 символа";
    }
  }

  String? validatorNum2(String? value) {
    if (value!.trim().isEmpty) {
      return "Обязательное поле";
    }
    if (value.length < 10) {
      return "Минимум 10 символов";
    }
  }

  String? validatorDT(DateTime? value) {
    if (value == null) {
      return "Обязательное поле";
    }
  }

  InputDecoration? decor() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      errorMaxLines: 4,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  static TextEditingController controllerNumInsurance = TextEditingController();
  static TextEditingController controllerSerInsurance = TextEditingController();
  static TextEditingController controllerBeginDate = TextEditingController();
  static TextEditingController controllerEndDate = TextEditingController();
  static TextEditingController controllerMinutes = TextEditingController();
  static TextEditingController controlleHours = TextEditingController();
  static TextEditingController controllerDays = TextEditingController();
  static TextEditingController controllerMonths = TextEditingController();
  static TextEditingController controllerTimeout = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(">>>>" + controllerEndDate.text);
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
                  Text('Номер страховки'),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 1,
                          controller: controllerSerInsurance,
                          decoration: decor()!.copyWith(
                              hintText: "ABC",
                              hintMaxLines: 2,
                              hintStyle: TextStyle(
                                fontSize: 13,
                              )),
                          validator: validatorNum,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z]")),
                            UpperCaseTextFormatter()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 1,
                          controller: controllerNumInsurance,
                          decoration: decor()!.copyWith(
                              hintText: "0000000000",
                              hintMaxLines: 2,
                              hintStyle: TextStyle(
                                fontSize: 13,
                              )),
                          validator: validatorNum2,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Column(
                            children: <Widget>[
                              Text('Дата начала действия страховки'),
                              const SizedBox(height: 5),
                              DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: 'dd-MM-yyyy',
                                controller: controllerBeginDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                icon: Icon(Icons.event),
                                decoration: decor(),
                                validator: validator,
                              ),
                              // DateTimeField(
                              //   format: DateFormat("dd-MM-yyyy"),
                              //   decoration: decor(),
                              //   validator: validatorDT,
                              //   controller: controllerBeginDate,
                              //   onShowPicker: (context, currentValue) {
                              //     return showDatePicker(
                              //         context: context,
                              //         firstDate: DateTime(1900),
                              //         initialDate: currentValue ?? DateTime.now(),
                              //         lastDate: DateTime(2100));
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Column(
                            children: <Widget>[
                              Text('Дата окончания действия страховки'),
                              const SizedBox(height: 5),
                              DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: 'dd-MM-yyyy',
                                controller: controllerEndDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                decoration: decor(),
                                validator: validator,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Установить тарифы'),
                  const SizedBox(height: 5),
                  Text('Минутный тариф'),
                  const SizedBox(height: 5),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    controller: controllerMinutes,
                    decoration: decor()!.copyWith(
                        hintText: "в ₽",
                        hintMaxLines: 2,
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    validator: validator,
                  ),
                  const SizedBox(height: 10),
                  Text('Часовой тариф'),
                  const SizedBox(height: 5),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    controller: controlleHours,
                    decoration: decor()!.copyWith(
                        hintText: "в ₽",
                        hintMaxLines: 2,
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    validator: validator,
                  ),
                  const SizedBox(height: 10),
                  Text('Дневной тариф'),
                  const SizedBox(height: 5),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    controller: controllerDays,
                    decoration: decor()!.copyWith(
                        hintText: "в ₽",
                        hintMaxLines: 2,
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    validator: validator,
                  ),
                  const SizedBox(height: 10),
                  Text('Месячный тариф'),
                  const SizedBox(height: 5),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    controller: controllerMonths,
                    decoration: decor()!.copyWith(
                        hintText: "в ₽",
                        hintMaxLines: 2,
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    validator: validator,
                  ),
                  const SizedBox(height: 10),
                  Text('Режим ожидания'),
                  Text('(* используется только в минутном тарифе)'),
                  const SizedBox(height: 5),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    controller: controllerTimeout,
                    decoration: decor()!.copyWith(
                        hintText: "в ₽",
                        hintMaxLines: 2,
                        hintStyle: TextStyle(
                          fontSize: 13,
                        )),
                    validator: validator,
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    title: Text("Использовать автомобиль в сервисе Такси"),
                    value: false,
                    onChanged: null,
                    controlAffinity: ListTileControlAffinity
                        .trailing, //  <-- leading Checkbox
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
