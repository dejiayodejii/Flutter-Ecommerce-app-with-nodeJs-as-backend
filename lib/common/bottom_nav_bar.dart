import 'package:flutter/material.dart';
import 'package:pushit/constants/global_variables.dart';
import 'package:pushit/features/account/views/account_screen.dart';
import 'package:pushit/features/cart/views/cart_screen.dart';
import 'package:pushit/features/home/views/home.dart';
import 'package:badges/badges.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int pageIndex = 0;

  List<Widget> pages = const[
    Home(),
    Account(),
    Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (val) {
          setState(() {
            pageIndex = val;
          });
        },
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 5,
                    color: pageIndex == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 5,
                    color: pageIndex == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 5,
                    color: pageIndex == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: Badge(
                elevation: 0,
                badgeContent: const Text('2'),
                badgeColor: Colors.white,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
