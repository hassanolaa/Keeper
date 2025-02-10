import 'package:flutter/material.dart';
import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:bookmarker/core/theming/size.dart';

class category extends StatelessWidget {
 category({super.key,required this.CategoryColor,required this.categoryName,required this.categoryCount});

  String CategoryColor;
  String categoryName;
  String categoryCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(0.3),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Stack(
        children: [
          // Green corner strip
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 60, // Width of the green strip
              height: 15, // Height of the green strip
              decoration: BoxDecoration(
                color: Color(int.parse(CategoryColor)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(6),
                ),
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$categoryName",
                      style: TextStyle(
                        fontSize: context.fontSize(16),
                        fontWeight: FontWeight.bold,
                        color: colors.coco,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$categoryCount",
                      style: TextStyle(
                        fontSize: context.fontSize(16),
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
