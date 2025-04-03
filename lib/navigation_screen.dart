import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screens/news_weather.dart';
import 'package:weatherapp/screens/weather_dashboard.dart';

class NavigationScreen extends StatefulWidget {
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // const NavigationScreen({super.key});
  int pageIndex = 0;

  List<Widget> pages = [
    WeatherDashboard(),
   WeatherNewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar:
      AnimatedBottomNavigationBar(
        icons: [
          CupertinoIcons.home,
          CupertinoIcons.news,
          
        ], 
        activeIndex:pageIndex ,
        activeColor: Colors.black,
        inactiveColor: Colors.black.withOpacity(0.5),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        rightCornerRadius:10 ,
        elevation: 0,
        
         onTap: (index){
          setState((){
            pageIndex=index;
          });
         }) ,
    );
  }
}