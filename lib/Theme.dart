import 'package:flutter/material.dart';

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

  //For 'List tile' in My Layouts
  Color listTileColor;
  Color listIconColor;

  //For Dialog boxes
  Color dialogTextColor;
  Color dialogButtonColor;

  //For Tabs
  Color tabColor;
  Color unselectedTabBorderColor;
  Color selectedTabBorderColor;
  Color selectedTabTextColor;
  Color unselectedTabTextColor;

  //For Gridview in layout select
  Color gridButtonColor;

  //For Sliders
  Color sliderColor;

  //For all buttons in active layouts
  var buttonColor;


  ThemeColors({
    this.primaryColor, 
    this.primaryBackgroundColor,
    this.accentColor,
    this.buttonTextColor,

    this.createBackgroundColor,
    this.createSplashColor,
    this.createBorderColor,
    this.createTextColor,

    this.listTileColor,
    this.listIconColor,

    this.dialogTextColor,
    this.dialogButtonColor,

    this.tabColor,
    this.unselectedTabBorderColor,
    this.selectedTabBorderColor,
    this.unselectedTabTextColor,
    this.selectedTabTextColor,

    this.gridButtonColor,

    this.sliderColor,

    this.buttonColor,
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

  listTileColor: Colors.white,
  listIconColor: Colors.indigoAccent,

  dialogTextColor: Colors.blue[800],
  dialogButtonColor: Colors.blue[800],

  tabColor: Colors.blue,
  unselectedTabBorderColor: Colors.blue,
  selectedTabBorderColor: Colors.white,
  unselectedTabTextColor: Colors.white54,
  selectedTabTextColor: Colors.white,

  gridButtonColor: Colors.blue[800],

  sliderColor: Colors.red,

  buttonColor: [Colors.blue[600],Colors.blue[800]],
);

var darkThemeColors = ThemeColors(
  primaryColor: Colors.black,
  primaryBackgroundColor: Colors.black54,
  accentColor: Colors.teal,
  buttonTextColor: Colors.white,

  createBackgroundColor: Colors.black,
  createSplashColor: Colors.grey[300],
  createBorderColor: Colors.teal,
  createTextColor: Colors.teal,

  listTileColor: Colors.black87,
  listIconColor: Colors.teal,

  dialogTextColor: Colors.white,
  dialogButtonColor: Colors.teal,

  tabColor: Colors.black,
  unselectedTabBorderColor: Colors.grey[900],
  selectedTabBorderColor: Colors.white,
  unselectedTabTextColor: Colors.white54,
  selectedTabTextColor: Colors.white,

  gridButtonColor: Colors.teal,

  sliderColor: Colors.teal,

  buttonColor: [Colors.teal[600],Colors.teal[800]],
);


var currentThemeColors;
