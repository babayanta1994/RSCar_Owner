import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Step5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Step5State();
  }
}

class Step5State extends State<Step5> {
   static TextEditingController controllerFilePath = TextEditingController();

  String? validator(String? value) {
    if (value is String?) {
      if (value!.trim().isEmpty) {
        return "Загрузите фото";
      }
    }
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
          Text('Загрузите фотографию страховки'),
          const SizedBox(height: 5),
         Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Container(
                child: controllerFilePath.text.trim().isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(controllerFilePath.text),
                          width: double.maxFinite,
                          height: (MediaQuery.of(context).size.height) * 0.55,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: double.maxFinite,
                        height: (MediaQuery.of(context).size.height) * 0.55,
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
          Container(
            height: 30,
            child: TextFormField(
              maxLines: 1,
              controller: controllerFilePath,
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
