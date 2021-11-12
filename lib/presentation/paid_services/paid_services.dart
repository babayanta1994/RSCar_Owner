import 'package:flutter/material.dart';
import 'package:rs_car_owner/presentation/home/home.dart';

class PaidServices extends StatefulWidget {
  @override
  _PaidServicesState createState() => _PaidServicesState();
}

class _PaidServicesState extends State<PaidServices> {
  bool gasoil = false;
  bool isGasoilDetailShow = false;

  bool wash = false;
  bool isWashShow = false;

  bool applyValue = false;

  onStepContinue(cont) {
    if (!gasoil && !wash) {
      showAlertDialog(cont);
    }
    else{
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Платные услуги'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Switch(
                                value: gasoil,
                                onChanged: (value) {
                                  setState(() {
                                    gasoil = value;
                                  });
                                }),
                            Expanded(
                              child: Text(
                                "Заправка",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            IconButton(
                              icon: isGasoilDetailShow
                                  ? Icon(Icons.keyboard_arrow_up_rounded)
                                  : Icon(Icons.keyboard_arrow_down_rounded),
                              onPressed: () {
                                setState(() {
                                  isGasoilDetailShow = !isGasoilDetailShow;
                                });
                              },
                            ),
                          ],
                        ),
                        isGasoilDetailShow
                            ? Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                        "Услуга включает: заправку автомобиля по мере необходимости. Мы отслеживаем количество топлива каждого автомобиля и вовремя заправляем."),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Стоимость: 2000р. / мес."),
                                    Text("Оплачивается ежемесячно."),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Switch(
                                value: wash,
                                onChanged: (value) {
                                  setState(() {
                                    wash = value;
                                  });
                                }),
                            Expanded(
                              child: Text(
                                "Мойка",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            IconButton(
                              icon: isWashShow
                                  ? Icon(Icons.keyboard_arrow_up_rounded)
                                  : Icon(Icons.keyboard_arrow_down_rounded),
                              onPressed: () {
                                setState(() {
                                  isWashShow = !isWashShow;
                                });
                              },
                            ),
                          ],
                        ),
                        isWashShow
                            ? Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                        "Услуга включает: мойку автомобиля по мере загрязнения. Перед каждой арендой пользователь может указать состояние автомобиля. После получения двух уведомдений, автомобиль отправляется на мойку."),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Стоимость: 2000р. / мес."),
                                    Text("Оплачивается ежемесячно."),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CheckboxListTile(
            title: Text(
              "Я принимаю условия договора",
              textAlign: TextAlign.end,
            ),
            value: applyValue,
            onChanged: (newValue) {
              setState(() {
                applyValue = newValue ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextButton(
                onPressed: applyValue
                    ? () {
                        onStepContinue(context);
                      }
                    : null,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
                child: const Text(
                  'Далее',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext cont) {
    AlertDialog alert = AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 50,
          ),
          Text("Вы уверены, что хотите отключить услуги?"),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Средства не будут возвращены"),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
              onPressed: () {
                Navigator.of(cont).pop();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              child: const Text(
                'Назад',
                style: TextStyle(fontSize: 17),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ])
        ],
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
