import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rs_car_owner/presentation/profile/addcard.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  String title = "";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileView> {
  var currentStep = 0;

  static TextEditingController controllerFilePath = TextEditingController();
  static TextEditingController controllerName = TextEditingController();
  static TextEditingController controllerFamilyName = TextEditingController();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerPhone = TextEditingController();

  String? validator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Обязательное поле";
      }
    }
  }

  InputDecoration? decor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  _imgFromCamera() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 100);

    setState(() {
      if (image != null) {
        controllerFilePath.text = image.path;
      }
    });
  }

  _imgFromGallery() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    setState(() {
      if (image != null) {
        controllerFilePath.text = image.path;
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Выбрать из галереи'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Сделать фото'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addCard(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddingCardView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 170,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0E1262),
                      Color(0xFF1D99EF),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Container(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      controllerFilePath.text.trim().isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: FileImage(
                                File(controllerFilePath.text),
                              ),
                              radius: 65,
                            )
                          : const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/stylist_placeholder_icon.png',
                              ),
                              radius: 65,
                            ),
                      Align(
                        child: Container(
                          height: 35,
                          width: 35,
                          child: FittedBox(
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                _showPicker(context);
                              },
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.blue,
                              ),
                              mini: true,
                            ),
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Личные данные",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerName,
                        decoration: InputDecoration(
                          label: Text("Имя"),
                        ),
                        validator: validator,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerFamilyName,
                        decoration: InputDecoration(
                          label: Text("Фамилия"),
                        ),
                        validator: validator,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          label: Text("Email"),
                        ),
                        validator: validator,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 1,
                        controller: controllerPhone,
                        decoration: InputDecoration(
                          label: Text("Номер телефона"),
                        ),
                        validator: validator,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Банковские реквизиты",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.note_alt_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                addCard(context);
                              }),
                        ],
                      ),
                      Text(
                        "Сохраненные реквизиты:",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Реквизиты еще не добавлены\nПожалуйста нажмите на кнопку \nРедактировать, чтобы добавить Банковские реквизиты",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
