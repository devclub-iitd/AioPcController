import 'package:flutter/material.dart';
import 'Theme.dart';
import 'LayoutSelect.dart';
import 'LoadCustom.dart';
import 'HomeScreen.dart';

class Tabs extends StatelessWidget {
  final String selected;
  Tabs(this.selected);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Material(
            color: currentThemeColors.tabColor,
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: selected == 'CONNECT'
                      ? currentThemeColors.selectedTabBorderColor
                      : currentThemeColors.unselectedTabBorderColor,
                  width: 2.0,
                ))),
                child: Center(
                  child: Text(
                    'CONNECT',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: selected == 'CONNECT'
                          ? currentThemeColors.selectedTabTextColor
                          : currentThemeColors.unselectedTabTextColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomeScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Material(
            color: currentThemeColors.tabColor,
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: selected == 'LAYOUTS'
                      ? currentThemeColors.selectedTabBorderColor
                      : currentThemeColors.unselectedTabBorderColor,
                  width: 2.0,
                ))),
                child: Center(
                  child: Text(
                    'LAYOUTS',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: selected == 'LAYOUTS'
                          ? currentThemeColors.selectedTabTextColor
                          : currentThemeColors.unselectedTabTextColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LayoutSelect(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Material(
            color: currentThemeColors.tabColor,
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: selected == 'CUSTOM'
                      ? currentThemeColors.selectedTabBorderColor
                      : currentThemeColors.unselectedTabBorderColor,
                  width: 2.0,
                ))),
                child: Center(
                  child: Text(
                    'CUSTOM',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: selected == 'CUSTOM'
                          ? currentThemeColors.selectedTabTextColor
                          : currentThemeColors.unselectedTabTextColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                loadCustomBuilder(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
