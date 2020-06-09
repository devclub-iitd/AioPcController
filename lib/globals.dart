import 'package:flutter/material.dart';

double gcurr = 0;
bool ovisit=false;
bool tiltcontrol = false;

class ThemeColors{
  Color primaryColor;
  Color primaryBackgroundColor;
  Color accentColor;
  Color buttonTextColor; 

  // For 'Create a layout button' in My Layouts
  Color createBackgroundColor;
  Color createSplashColor;
  Color createBorderColor;
  Color createTextColor;


  ThemeColors({
    this.primaryColor, 
    this.primaryBackgroundColor,
    this.accentColor,
    this.buttonTextColor,

    this.createBackgroundColor,
    this.createSplashColor,
    this.createBorderColor,
    this.createTextColor,

  });
}

var lightThemeColors = ThemeColors(
  primaryColor: Colors.blue,
  primaryBackgroundColor: Colors.white,
  accentColor: Colors.blue,
  buttonTextColor: Colors.white,

  createBackgroundColor: Colors.grey[200],
  createSplashColor: Colors.grey[300],
  createBorderColor: Colors.black12,
  createTextColor: Colors.grey,

);

var currentThemeColors = lightThemeColors;

var lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: currentThemeColors.primaryColor,
  accentColor: currentThemeColors.accentColor,
);
