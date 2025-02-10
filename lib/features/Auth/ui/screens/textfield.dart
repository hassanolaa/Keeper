import 'package:flutter/material.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/core/theming/colors.dart';

class textfield extends StatelessWidget {
  textfield({
    required this.textfieldname,
    required this.textfieldhinttext,
    required this.textfieldicon,
    required this.password,
    required this.controller,
    required this.number,
    super.key,
  });

  String? textfieldname;
  String? textfieldhinttext;
  Icon? textfieldicon;
  bool? password;
  bool? number;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // text field title
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textfieldname!,
              style: TextStyle(
                  fontSize: context.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: colors.text,
                  fontFamily: 'Manrope'),
            ),
            context.width_box(0.02),
          ],
        ),
        context.height_box(0.01),
        // text field
        Container(
          width: context.width(0.8),
          height: context.height(0.08),
          child: Padding(
            padding: EdgeInsets.only(left: context.width(0.02)),
            child: TextField(
              keyboardType:number!? TextInputType.number:null,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              controller: controller,
              obscureText: password!,
              decoration: InputDecoration(
                  suffixIcon: password!
                      ? Icon(Icons.visibility_off, color: colors.text)
                      : null,
                  icon: textfieldicon,
                  iconColor: colors.text,
                  hintText: textfieldhinttext!,
                  hintStyle: TextStyle(
                      fontSize: context.fontSize(16),
                      fontWeight: FontWeight.normal,
                      color: colors.primary,
                      fontFamily: 'Manrope'),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: colors.sub_background, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: colors.sub_background, width: 0))),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xfff3f4f6),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
