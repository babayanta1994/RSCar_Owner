import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/app_register/register_steps/register_step1.dart';
import 'package:rs_car_owner/presentation/app_register/register_steps/register_step2.dart';
import 'package:rs_car_owner/presentation/app_register/register_steps/register_step3.dart';
import 'package:rs_car_owner/presentation/app_register/register_steps/register_upload.dart';
import 'package:rs_car_owner/presentation/home/home.dart';

class AppRegister extends StatefulWidget {
  AppRegister({Key? key}) : super(key: key);
  String title = "Регистрация";
  @override
  _AppRegisterState createState() => _AppRegisterState();
}

class _AppRegisterState extends State<AppRegister> {
  var currentStep = 0;
  @override
  Widget build(BuildContext context) {
    var mapData = HashMap<String, String>();
    // mapData["email"] = Step2State.controllerEmail.text;
    // mapData["address"] = Step2State.controllerAddress.text;
    mapData["manageStatus"] = RegisterStep1State.checkedValue ? "1" : "0";

    List<Step> steps = [
      Step(
        title: Text(''),
        content: RegisterStep1(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: RegisterStep2(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: RegisterStep3(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      // Step(
      //   title: Text(''),
      //   content: Step2(),
      //   state: currentStep == 1 ? StepState.editing : StepState.indexed,
      //   isActive: true,
      // ),
      Step(
        title: Text(''),
        content: RegisterUpload(mapData),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Stepper(
          controlsBuilder: (BuildContext context,
              {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
            if (currentStep < steps.length - 1) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: onStepCancel,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Назад'),
                  ),
                  TextButton(
                    onPressed: onStepContinue,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Далее'),
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: onStepContinue,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Принять'),
                  ),
                ],
              );
            }
          },
          currentStep: currentStep,
          steps: steps,
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
                    RegisterStep1State.formKey.currentState!.validate()) {
                  if (RegisterStep1State.checkedValue) {
                    currentStep = currentStep + 1;
                  } else {
                    currentStep = currentStep + 3;
                  }
                } else if (currentStep == 1 &&
                    RegisterStep2State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 2 &&
                    RegisterStep3State.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                }
                // else if (currentStep == 3 &&
                //     Step4State.formKey.currentState!.validate()) {
                //   currentStep = currentStep + 1;
                // } else if (currentStep == 4 &&
                //     Step5State.formKey.currentState!.validate()) {
                //   currentStep = currentStep + 1;
                // } else if (currentStep == 5 &&
                //     Step6State.formKey.currentState!.validate()) {
                //   currentStep = currentStep + 1;
                // }
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
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
