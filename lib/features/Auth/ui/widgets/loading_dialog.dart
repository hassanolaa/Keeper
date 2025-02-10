import 'package:flutter/material.dart';
import 'package:bookmarker/core/theming/colors.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(color: colors.coco,),
      ),
    );
  }
}
