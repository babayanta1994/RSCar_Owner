import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zendesk2/zendesk2.dart';
import 'package:rs_car_owner/presentation/support/support_pages/support_answer.dart';
import 'package:rs_car_owner/presentation/support/support_pages/support_chat.dart';

class SupportZenDesk extends StatefulWidget {
  @override
  _SupportZenDeskState createState() => _SupportZenDeskState();
}

class _SupportZenDeskState extends State<SupportZenDesk> {
  final z = Zendesk.instance;

  String accountKey = '4gOKyAJKAIjUB55crTmOCvQZ1EanL426';
  String appId = 'cadc5a376d7288d025185b3ddbfb13d990c65ac9d41f75d5';
  String clientId = 'mobile_sdk_client_61e298ab64cc2a6c8d26';
  String zendeskUrl = 'https://rscardrivehelp.zendesk.com';

  void answer() async {
    z.initAnswerSDK(appId, clientId, zendeskUrl);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ZendeskAnswerUI()));
  }

  void chat() async {
    String name = '';
    String email = '';
    String phoneNumber = '';

    await z.initChatSDK(accountKey, appId);

    Zendesk2Chat zChat = Zendesk2Chat.instance;

    await zChat.setVisitorInfo(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      tags: ['app', 'zendesk2_plugin'],
    );

    await Zendesk2Chat.instance.startChatProviders(autoConnect: false);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ZendeskChat()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Связь с поддержкой'),
      ),
      body: Center(
        child: Text('Выберите способ связи'),
      ),
      floatingActionButton: Container(
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                heroTag: 'answer',
                icon: Icon(FontAwesomeIcons.comment),
                label: Text('Написать на почту'),
                onPressed: () {
                  print("tap");
                },
              ),
              FloatingActionButton.extended(
                heroTag: 'chat',
                icon: Icon(FontAwesomeIcons.comments),
                label: Text('Чат с поддержкой'),
                onPressed: chat,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
