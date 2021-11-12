import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/add_car/steps/step2.dart';
import 'package:rs_car_owner/presentation/add_car/steps/step1.dart';
import 'package:rs_car_owner/presentation/add_car/steps/step3.dart';
import 'package:rs_car_owner/presentation/add_car/steps/step4.dart';
import 'package:rs_car_owner/presentation/add_car/steps/step5.dart';
import 'package:rs_car_owner/presentation/add_car/steps/step6.dart';
import 'package:rs_car_owner/presentation/add_car/steps/step_pts.dart';
import 'package:rs_car_owner/presentation/add_car/steps/upload.dart';
import 'package:rs_car_owner/presentation/add_car/steps/success_add.dart';

class AddCarView extends StatefulWidget {
  AddCarView({Key? key}) : super(key: key);

  String title = "Добавить авто";
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCarView> {
  var currentStep = 0;

  @override
  Widget build(BuildContext context) {
    var mapData = HashMap<String, String>();
    mapData["category"] = Step1State.controllerCategory.text;
    mapData["brand"] = Step1State.selectedBrand;
    mapData["model"] = Step1State.selectedModel;
    mapData["year"] = Step1State.selectedYear.toString();
    mapData["color"] = Step1State.selectedColor;
    mapData["country"] = Step1State.selectedCountry;
    mapData["city"] = Step1State.selectedCity;
    // mapData["email"] = Step2State.controllerEmail.text;
    // mapData["address"] = Step2State.controllerAddress.text;
    // mapData["mobile_no"] = Step2State.controllerMobileNo.text;

    List<Step> steps = [
      Step(
        title: Text(''),
        content: Step1(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Step2(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Step3(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Step6(),
        state: currentStep == 3 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Step4(),
        state: currentStep == 4 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Step5(),
        state: currentStep == 5 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: StepPts(),
        state: currentStep == 6 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Upload(mapData),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    //OTP
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Color(0xf8f8f8),
        child: Stepper(
          controlsBuilder: (BuildContext context,
              {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                currentStep != 0
                    ? TextButton(
                        onPressed: onStepCancel,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                        ),
                        child: const Text('Назад'),
                      )
                    : SizedBox(),
                TextButton(
                  onPressed: onStepContinue,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  ),
                  child: currentStep != steps.length - 1
                      ? const Text('Далее')
                      : const Text('Отправить заявку'),
                ),
              ],
            );
          },
          currentStep: currentStep,
          steps: steps,
          physics: NeverScrollableScrollPhysics(),
          type: StepperType.horizontal,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                if (currentStep == 0 &&
                    Step1State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 1 &&
                    Step2State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 2 &&
                    Step3State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 3 &&
                    Step6State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 4 &&
                    Step4State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 5 &&
                    Step5State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 6 &&
                    StepPtsState.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                }
              } else {
                Route route =
                    MaterialPageRoute(builder: (context) => SuccessAdd());
                Navigator.pushReplacement(context, route);
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                currentStep = 0;
              }
            });
          },
        ),
      ),
    );
  }
}
