import 'package:esmserviceweb/utility/my_constant.dart';
import 'package:esmserviceweb/widgets/show_text.dart';
import 'package:flutter/material.dart';

class ShowTextButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  const ShowTextButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressFunc,
        child: ShowText(
          text: label,
          textStyle: MyConstant().h3ActiveStyle(),
        ));
  }
}
