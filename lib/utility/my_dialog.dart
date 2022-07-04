import 'package:esmserviceweb/utility/my_constant.dart';
import 'package:esmserviceweb/widgets/show_image.dart';
import 'package:esmserviceweb/widgets/show_text.dart';
import 'package:esmserviceweb/widgets/show_text_button.dart';
import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog({
    required String title,
    required String subTitle,
    String? label,
    Function()? pressFunc,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 100,
            child: ShowImage(),
          ),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: subTitle),
        ),
        actions: [
          label == null
              ? ShowTextButton(
                  label: 'OK',
                  pressFunc: () {
                    Navigator.pop(context);
                  },
                )
              : ShowTextButton(label: label, pressFunc: pressFunc!),
        ],
      ),
    );
  }
}
