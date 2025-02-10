
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/features/Auth/ui/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'navi.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobView(
        widget: FlutterSplashScreen.fadeIn(
        duration: Duration(seconds: 2),
        //backgroundColor: Appcolors.primaryColor,
        backgroundImage: Image.asset('images/gif.gif'),
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(),

        onAnimationEnd: () => debugPrint("On Fade In End"),
        // nextScreen: navi(),
         nextScreen: FirebaseAuth.instance.currentUser!=null? navi():SignUpPage() ,

      ),
        
        )
    );
  }
}