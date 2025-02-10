import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/Add_marks_And_notes/ui/screens/addNote.dart';
import 'package:flutter/material.dart';

import 'addBookmark.dart';

class add extends StatelessWidget {
  const add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add new',
              style: TextStyle(
                fontSize: context.fontSize(30),
                fontWeight: FontWeight.bold,
              ),
            ),
            context.height_box(0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    context.navigateTo(addBookmark());
                  },
                  child: Container(
                      width: context.width(0.3),
                      height: 100,
                      decoration: BoxDecoration(
                        color: colors.coco,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_border,
                            size: context.fontSize(30),
                            color: Colors.white,
                          ),
                          context.height_box(0.01),
                          Text(
                            'Bookmark',
                            style: TextStyle(
                              fontSize: context.fontSize(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    context.navigateTo(addnote());
                  },
                  child: Container(
                      width: context.width(0.3),
                      height: 100,
                      decoration: BoxDecoration(
                        color: colors.coco,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: context.fontSize(30),
                            color: Colors.white,
                          ),
                            context.height_box(0.01),
                          Text(
                            'Note',
                            style: TextStyle(
                              fontSize: context.fontSize(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
