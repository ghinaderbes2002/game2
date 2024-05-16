import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class PageFooter extends StatelessWidget {
  final Color? color;
  final IconData iconData;
  final IconData iconData2;
  final IconData iconData3;
  final dynamic Function(int)? onTap;
  const PageFooter({
    Key? key,
    required this.color,
    required this.iconData,
    required this.iconData2,
    required this.iconData3,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 123,
      child: DotNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTap,
        items: [
          DotNavigationBarItem(
            icon: Icon(iconData),
            selectedColor: color,
          ),
          DotNavigationBarItem(
            icon: Icon(iconData2),
            selectedColor: color,
          ),
          DotNavigationBarItem(
            icon: Icon(iconData3),
            selectedColor: color,
          ),
        ],
      ),
    );
  }
}
