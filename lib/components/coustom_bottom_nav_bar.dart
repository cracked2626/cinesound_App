import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../enums.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
    @required this.onTapChangePage,
    @required this.getPageIndex,
  }) : super(key: key);

  final MenuState selectedMenu;
  final Function onTapChangePage;
  final int getPageIndex;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState(
      onTapChangePage: onTapChangePage, getPageIndex: getPageIndex);
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final Function onTapChangePage;
  final int getPageIndex;
  _CustomBottomNavBarState({this.onTapChangePage, this.getPageIndex});
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return CupertinoTabBar(
      // iconSize: 40.0,

      backgroundColor: Colors.white,
      currentIndex: getPageIndex,
      onTap: onTapChangePage,
      activeColor: Color.fromRGBO(255, 45, 85, 1),
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/Shop Icon.svg")),
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/Cart Icon.svg")),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/User Icon.svg")),
      ],
    );
  }
}
