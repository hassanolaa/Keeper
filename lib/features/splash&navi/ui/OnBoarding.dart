import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/features/splash&navi/ui/navi.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  Widget _buildImage(String assetName, [double width = 150]) {
    return Column(
      children: [
        //SizedBox(height: 1,),
        Image.asset('images/$assetName', width: width,fit: BoxFit.fitWidth,height: 300,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return MobView(
      widget: IntroductionScreen(
        onDone: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => navi(),
              ));
        },
        onSkip: () {
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => navi(),
              ));
        }, // You can override onSkip callback
        
        globalBackgroundColor: colors.background,
        showSkipButton: true,
        showNextButton: true,
        back: const Icon(
          Icons.arrow_back,
          color: colors.background,
        ),
        skip: const Text('Skip',
            style:
                TextStyle(color: colors.background, fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward, color:colors.background),
        done: const Text('Done',
            style:
                TextStyle(color: colors.background, fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color:colors.background,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: colors.coco,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Store, Organize, Remember",
            body:
                "All in Keeper.",
            image: _buildImage('logo_png.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Your data is safe",
            body:
                "The easiest way to save your notes and Bookmarks",
            image: _buildImage('man.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Use it on any device",
            body:
                "Keeper is available on all platforms",
            image: _buildImage('platforms.png'),
            decoration: pageDecoration,
          ),
        ],
      ),
    );
  }
}
