import 'package:flutter/material.dart';

import 'package:esmserviceweb/utility/my_constant.dart';

class ShowForm extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final Function(String) changeFunc;
  final bool? obscure;
  final Function()? redEyeFunc;
  const ShowForm({
    Key? key,
    required this.hint,
    required this.iconData,
    required this.changeFunc,
    this.obscure,
    this.redEyeFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        obscureText: obscure ?? false,
        onChanged: changeFunc,
        style: MyConstant().h3Style(),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.75),
          filled: true,
          suffixIcon: redEyeFunc == null
              ? Icon(
                  iconData,
                  color: MyConstant.light,
                )
              : IconButton(
                  onPressed: redEyeFunc,
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: MyConstant.light,
                  )),
          hintStyle: MyConstant().h3HintStyle(),
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.dark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.primary),
          ),
        ),
      ),
    );
  }
}
