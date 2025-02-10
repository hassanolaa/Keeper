


import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/Add_marks_And_notes/ui/screens/add.dart';
import 'package:bookmarker/features/Bookmark/ui/screens/bookmarks.dart';
import 'package:bookmarker/features/Note/ui/screens/notes.dart';
import 'package:bookmarker/features/home/ui/screens/homeScreen.dart';
import 'package:bookmarker/features/home/ui/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../Auth/ui/screens/sign_up.dart';

class navi extends StatefulWidget {
  const navi({super.key});

  @override
  State<navi> createState() => _naviState();
}

class _naviState extends State<navi> {

    int _selectedIndex = 0;
  List<Widget> items = [
    homeScreen(),
    bookmarks(),
    add(),
    notes(),
    ProfileScreen(),

  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return MobView(
      widget: Scaffold(
        
        body: items.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
           // color:Color(0xFFDAD4FA),
           image: DecorationImage(image: AssetImage('images/background.png'),fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 4,
                activeColor: const Color.fromARGB(255, 237, 237, 237),
                iconSize: context.fontSize(22),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor:const Color(0xFF262B4F),
                color: Color(0xFF262B4F),
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                   // text: 'Home',
                  ),
                   GButton(
                    icon: Icons.bookmark_border,
                   // text: 'Events',
                  ),
                  GButton(
                    iconSize: context.fontSize(34),
                    icon: Icons.add_circle_outline_rounded,
                   // text: 'Map',
                  ),
                  GButton(
                    icon: Icons.note_alt_outlined,
                   // text: 'Favorites',
                  ),
                  GButton(
                    icon: Icons.person_outline,
                   // text: 'Profile',
                  ),
                  
                 
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}