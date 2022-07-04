import 'package:esmserviceweb/utility/my_constant.dart';
import 'package:esmserviceweb/widgets/show_text.dart';
import 'package:flutter/material.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;

  const ShowButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyConstant.primary,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: pressFunc,
        child: ShowText(
          text: label,
          textStyle: MyConstant().h3ButtonStyle(),
        ));
  }
}
