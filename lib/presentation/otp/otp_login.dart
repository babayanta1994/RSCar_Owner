import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rs_car_owner/internal/app.dart';
import 'package:rs_car_owner/presentation/app_register/app_register.dart';
import 'package:rs_car_owner/presentation/home/home.dart';
import 'package:rs_car_owner/presentation/support/support_main.dart';
import 'package:sms_autofill/sms_autofill.dart';

enum MobileVerificationState {
  SHOW_OTP_MOBILE,
  SHW_OTP_AWAIT,
}

class OtpLogin extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OtpLogin> with CodeAutoFill {
  String _countDown = "";
  late OTPCountDown _otpCountDown;
  final int _otpTimeInMS = 1000 * 60;

  FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;
  bool isLoaderShown = false;

  bool isCountDounFinished = false;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_OTP_MOBILE;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController controllerCode =
      TextEditingController.fromValue(const TextEditingValue(text: "+7"));
  TextEditingController controllerPhone = TextEditingController();

  TextEditingController controllerPin = TextEditingController();

  @override
  void codeUpdated() {
    print(">>>>>> ${code!}");
    setState(() {
      controllerPin.text = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {});
  }

  InputDecoration? decor() {
    return const InputDecoration(
      prefixIcon: Icon(Icons.phone_android),
      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  String? validator(String? value) {
    if (value == null) {
      return "Введите корректный номер";
    }
    if (value.length > 10 || value.length < 9) {
      return "Введите корректный номер";
    }
  }

  signInWithCredetial(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      isLoaderShown = true;
    });
    try {
      UserCredential authCredential = await _auth
          .signInWithCredential(phoneAuthCredential)
          .catchError((error) {
        print(">>>> errror code " + error.code);
        String ecode = error.code;
        if (ecode.contains("invalid-verification-code")) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Неверный код")));
        }
      });
      setState(() {
        isLoaderShown = false;
      });
      if (authCredential.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
      } else {
        print(">>>> not correct code");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoaderShown = false;
      });

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoaderShown
        ? Center(
            child: CircularProgressIndicator(),
          )
        : currentState == MobileVerificationState.SHOW_OTP_MOBILE
            ? getOtpMobile(context)
            : getOtpAwait(context);
  }

  void _startCountDown() {
    isCountDounFinished = false;
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        setState(() {});
      },
      onFinish: () {
        isCountDounFinished = true;
        setState(() {});
      },
    );
  }

  pressSendOtp() async {
    
    controllerPin.text ="";
    if (currentState == MobileVerificationState.SHOW_OTP_MOBILE) {
      if (!formKey.currentState!.validate()) {
        return;
      }
    }

    setState(() {
      isLoaderShown = true;
    });
    print(controllerCode.text + controllerPhone.text);

    await _auth.verifyPhoneNumber(
        phoneNumber: controllerCode.text + controllerPhone.text,
        verificationCompleted: (PhoneAuthCredential pac) async {
          print("verificationCompleted");
          setState(() {
            isLoaderShown = false;
          });
        },
        verificationFailed: (FirebaseAuthException ex) async {
          print("verificationFailed");
          setState(() {
            isLoaderShown = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Ошибка верификации")));
        },
        codeSent: (String verificationId, int? resendToken) async {
          print("codeSent");
          setState(() {
            isLoaderShown = false;
            currentState = MobileVerificationState.SHW_OTP_AWAIT;
            this.verificationId = verificationId;

            _startCountDown();
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) async {});
  }

  getOtpMobile(context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6E2EA),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.maxFinite,
              child: Center(
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/new_logo.png',
                        color: Colors.white,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          child: Text(
                            "Войдите в приложение",
                            style: TextStyle(color: Colors.white),
                          ),
                          padding: EdgeInsets.only(bottom: 10, right: 10),
                        )),
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF35A3FA),
                    Color(0xFF031265),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          CountryCodePicker(
                            onChanged: (CountryCode code) {
                              controllerCode.text = code.dialCode.toString();
                              print(controllerCode.text);
                            },
                            initialSelection: 'RU',
                            favorite: ['+7', 'RU'],
                            showDropDownButton: true,
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            flagWidth: 25,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              maxLines: 1,
                              controller: controllerPhone,
                              decoration: decor()!.copyWith(
                                  hintText: "Номер телефона",
                                  hintStyle: TextStyle(fontSize: 10)),
                              validator: validator,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: FractionallySizedBox(
                      widthFactor:
                          1, // means 100%, you can change this to 0.8 (80%)
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF35A3FA),
                                Color(0xFF031265),
                              ],
                            ),
                          ),
                          child: TextButton(
                            onPressed: pressSendOtp,
                            child: const Text(
                              'Далее',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                            side: BorderSide(color: Colors.blue.shade900),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return SupportZenDesk();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getOtpAwait(context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFFD6E2EA),
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 4 / 5,
                          child: const Text(
                            "Подтверждение телефона",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 4 / 5,
                          child: const Text(
                            "Введите полученный код",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 4 / 5,
                          child: Text(
                            "${controllerCode.text + controllerPhone.text}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.lightBlue),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: PinPut(
                            fieldsCount: 6,
                            onSubmit: (String pin) {
                              PhoneAuthCredential phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: this.verificationId!,
                                      smsCode: pin);
                              signInWithCredetial(phoneAuthCredential);
                            },
                            eachFieldMargin:
                                EdgeInsets.symmetric(horizontal: 0),
                            // focusNode: _pinPutFocusNode,
                            controller: controllerPin,
                            submittedFieldDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500.0),
                              border: Border.all(
                                color: Colors.blue.withOpacity(.5),
                              ),
                            ),
                            selectedFieldDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500.0),
                              border: Border.all(
                                color: Colors.blue.withOpacity(.5),
                              ),
                            ),
                            followingFieldDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500.0),
                              border: Border.all(
                                color: Colors.blueGrey.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        isCountDounFinished
                            ? TextButton(
                                child: Text("Отправить ещё раз"),
                                onPressed: pressSendOtp,
                              )
                            : Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Получить код повторно через: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      _countDown,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
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
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  side: BorderSide(color: Colors.blue.shade900),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return SupportZenDesk();
                              }));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          setState(() {
            currentState = MobileVerificationState.SHOW_OTP_MOBILE;
          });
          return false;
        });
  }

  void _navigateToOtpAwait(BuildContext context) {
    if (this.formKey.currentState!.validate()) {}
  }
}
