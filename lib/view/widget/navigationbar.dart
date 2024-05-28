import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class PageFooter extends StatelessWidget {
  final Color? color;
  final IconData iconData;
  final IconData iconData2;
  final IconData iconData3;
  final int pageIndex;
  final dynamic Function(int)? onTap;
  const PageFooter({
    Key? key,
    required this.color,
    required this.iconData,
    required this.iconData2,
    required this.iconData3,
    this.onTap,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 123,
      child: DotNavigationBar(
        currentIndex: pageIndex,
        backgroundColor: Colors.black45,
        onTap: onTap,
        enableFloatingNavBar: true,
        items: [
          DotNavigationBarItem(
            icon: Icon(iconData),
            unselectedColor: Colors.white,
            selectedColor: color,
          ),
          DotNavigationBarItem(
            unselectedColor: Colors.white,
            icon: Icon(iconData2),
            selectedColor: color,
          ),
          DotNavigationBarItem(
            unselectedColor: Colors.white,
            icon: Icon(iconData3),
            selectedColor: color,
          ),
        ],
      ),
    );
  }
}
