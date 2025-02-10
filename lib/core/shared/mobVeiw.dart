



import 'package:bookmarker/core/theming/size.dart';
import 'package:flutter/material.dart';
import 'package:bookmarker/core/routing/router.dart';

class MobView extends StatelessWidget {
   MobView({Key? key,
   
   required this.widget
   }) : super(key: key);

  Widget widget;

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Container(
                  // The container acts like a "mobile screen" inside the desktop screen
            width: context.isMobileView ?context.screenWidth :context.mobileWidth, // Mobile width or full screen width for larger screens
            height:context.isMobileView ? null : 700, // Adjust height for non-mobile view
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: context.isMobileView ? null : BorderRadius.circular(10),
              border:context. isMobileView
                  ? null
                  : Border.all(color: Colors.white, width: 20), // White border for larger screens
            ),
                child:widget
              ),
            );
  }
}