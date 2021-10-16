import 'package:flutter/material.dart';
import 'package:shop_app/Config/config.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int getPageIndex = 0;

  onTapChangePage(int pageindex) {
    controller.animateToPage(pageindex,
        duration: Duration(milliseconds: 2),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  check() async {
    var t =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    print('check');
    print(t);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(
        whenPageChanges: whenPageChanges,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
        getPageIndex: getPageIndex,
        onTapChangePage: onTapChangePage,
      ),
    );
  }
}
