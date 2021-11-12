import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Step6 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Step6State();
  }
}

class Step6State extends State<Step6> {
  int current = 0;
  static List<TextEditingController> controllerFilePath = [];
  static TextEditingController emptyController = TextEditingController();

  String? validator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Загрузите фото";
      }
    }
  }

  _imgFromCamera(i) async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 100);

    setState(() {
      if (image != null) {
        if (i == -1)
          controllerFilePath.add(TextEditingController(text: image.path));
        else
          controllerFilePath[i] = TextEditingController(text: image.path);
      }
    });
  }

  _imgFromGallery(i) async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    setState(() {
      if (image != null) {
        if (i == -1)
          controllerFilePath.add(TextEditingController(text: image.path));
        else
          controllerFilePath[i] = TextEditingController(text: image.path);
      }
    });
  }

  void _showPicker(context, i) {
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
                        _imgFromGallery(i);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Сделать фото'),
                    onTap: () {
                      _imgFromCamera(i);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              'Загрузите фотографии автомобиля \n (минимум 1 фотография)',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 5),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              if (controllerFilePath.length < 6)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context, -1);
                    },
                    child: Container(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/uploadctc.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              for (var i = 0; i < controllerFilePath.length; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context, i);
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(controllerFilePath[i].text),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Align(
                          child: Container(
                            height: 35,
                            width: 35,
                            child: FittedBox(
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  controllerFilePath.removeAt(i);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
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
            ],
          ),
          Container(
            height: 30,
            child: TextFormField(
              maxLines: 1,
              controller: controllerFilePath.length>0?controllerFilePath[0]:emptyController,
              validator: validator,
              style: TextStyle(
                color: Colors.transparent,
                fontSize: 0,
                height: 0,
              ),
              readOnly: true,
              // enabled: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
