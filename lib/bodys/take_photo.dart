import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:esmserviceweb/utility/my_constant.dart';
import 'package:esmserviceweb/utility/my_dialog.dart';
import 'package:esmserviceweb/widgets/show_button.dart';
import 'package:esmserviceweb/widgets/show_form.dart';
import 'package:esmserviceweb/widgets/show_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({Key? key}) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File? file;
  String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newImage(context: context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newFormTitle(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonUpload(),
            ],
          ),
        ],
      ),
    );
  }

  Container buttonUpload() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: 250,
      child: ShowButton(
        label: 'Upload',
        pressFunc: () {
          if (file == null) {
            MyDialog(context: context).normalDialog(
                title: 'No Photo.', subTitle: 'Please Take Photo.');
          } else if (title?.isEmpty ?? true) {
            MyDialog(context: context).normalDialog(
                title: 'No Title.', subTitle: 'Please Fill Title.');
          } else {
            processUpload();
          }
        },
      ),
    );
  }

  Container newFormTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: ShowForm(
        hint: 'Title :',
        iconData: Icons.image,
        changeFunc: (String string) {
          title = string.trim();
        },
      ),
    );
  }

  Container newImage({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: file == null
                ? const ShowImage(
                    path: 'images/image.png',
                  )
                : Image.file(file!),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                MyDialog(context: context).normalDialog(
                  title: 'Source Image?',
                  subTitle: 'Please Tab Camera or Gallery',
                  label: 'Camera',
                  pressFunc: () {
                    Navigator.pop(context);
                    processTakePhoto(source: ImageSource.camera);
                  },
                  label2: 'Gallery',
                  pressFunc2: () {
                    Navigator.pop(context);
                    processTakePhoto(source: ImageSource.gallery);
                  },
                );
              },
              icon: Icon(
                Icons.add_a_photo_outlined,
                size: 48,
                color: MyConstant.active,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> processTakePhoto({required ImageSource source}) async {
    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (result != null) {
      setState(() {
        file = File(result.path);
      });
    }
  }

  Future<void> processUpload() async {
    String pathApiUpload =
        'https://www.androidthai.in.th/egat/saveImageMan.php';
    String nameImage = 'man${Random().nextInt(10000000)}.jpg';
    Map<String, dynamic> map = {};
    map['file'] = await MultipartFile.fromFile(file!.path, filename: nameImage);
    FormData formData = FormData.fromMap(map);
    await Dio().post(pathApiUpload, data: formData).then((value) async {
      String urlImage = 'https://www.androidthai.in.th/egat/man/$nameImage';
      print('##urlImage ===> $urlImage');

      String pathApiInsertData =
          "https://www.androidthai.in.th/egat/insertImageMan.php?isAdd=true&title=$title&urlImage=$urlImage";
      await Dio().get(pathApiInsertData).then((value) {
        MyDialog(context: context).normalDialog(
            title: 'Upload and Insert Success.', subTitle: 'Completed');
      });
    });
  }
}
