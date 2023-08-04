import 'package:flutter/material.dart';
import 'package:marketjet/Screens/Navigation_Bar_Screen/cart_screen.dart';
import 'package:marketjet/Screens/Navigation_Bar_Screen/favorite_screen.dart';
import 'package:marketjet/Screens/Navigation_Bar_Screen/home_screen.dart';
import 'package:marketjet/Screens/Navigation_Bar_Screen/more_screen.dart';
import 'package:marketjet/Screens/Navigation_Bar_Screen/profile_screen.dart';
import 'package:marketjet/ui_helpher.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home_Page extends StatefulWidget {
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  int _currentIndex = 2;

  /// Screen page
  final screens = [
    More_Screen(),
    Favorite_Screen(),
    Home_Screen(),
    Cart_Screen(),
    Profile_Screen()
  ];

  @override
  Widget build(BuildContext context) {

    /// Items //
    final items = <Widget>[

        Icon(Icons.widgets_outlined, size: 25,
            color: _currentIndex == 0 ? AppColor.WhiteColor : AppColor.GreyLight,
        ),

        Icon(Icons.favorite_border, size: 25,
            color: _currentIndex == 1 ? AppColor.WhiteColor : AppColor.GreyLight,
        ),

        Icon(Icons.home, size: 25,
            color: _currentIndex == 2 ? AppColor.WhiteColor : AppColor.GreyLight,
        ),

        Icon(Icons.shopping_cart_outlined, size: 25,
            color: _currentIndex == 3 ? AppColor.WhiteColor : AppColor.GreyLight,
        ),

        Icon(Icons.person_outline_outlined, size: 25,
            color: _currentIndex == 4 ? AppColor.WhiteColor : AppColor.GreyLight,
        )

    ];


    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: AppColor.OrangeColor,
            color: AppColor.WhiteColor,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            items: items,
            index: _currentIndex,
            onTap: (mIndex) {
              setState(() {
                this._currentIndex = mIndex;
              });
            },
          ),

          body: screens[_currentIndex],
        ),
      ),
    );
  }
}
