import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:esmserviceweb/models/photo_model.dart';
import 'package:esmserviceweb/utility/my_constant.dart';
import 'package:esmserviceweb/widgets/show_progress.dart';
import 'package:esmserviceweb/widgets/show_text.dart';
import 'package:flutter/material.dart';

class ListPhoto extends StatefulWidget {
  const ListPhoto({Key? key}) : super(key: key);

  @override
  State<ListPhoto> createState() => _ListPhotoState();
}

class _ListPhotoState extends State<ListPhoto> {
  var photoModels = <PhotoModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllPhoto();
  }

  Future<void> readAllPhoto() async {
    String pathAPI = 'https://www.androidthai.in.th/egat/getAllPhotoMan.php';
    await Dio().get(pathAPI).then((value) {
      print('##value readAllPhoto ===> $value');

      for (var element in json.decode(value.data)) {
        print('##element === > $element');
        PhotoModel photoModel = PhotoModel.fromMap(element);
        photoModels.add(photoModel);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return photoModels.isEmpty
        ? const ShowProgress()
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints boxConstraints) {
            return ListView.builder(
              itemCount: photoModels.length,
              itemBuilder: (context, index) => Card(
                child: Row(
                  children: [
                    SizedBox(
                      width: boxConstraints.maxWidth * 0.5 - 8,
                      height: boxConstraints.maxWidth * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(photoModels[index].urlImage),
                      ),
                    ),
                    SizedBox(
                      width: boxConstraints.maxWidth * 0.5,
                      height: boxConstraints.maxWidth * 0.4,
                      child: ShowText(
                        text: photoModels[index].title,
                        textStyle: MyConstant().h2Style(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
  }
}
