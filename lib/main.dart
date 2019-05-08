import 'package:flutter_web/material.dart';
import 'package:wallpaper_web/wallpaper_home.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wallpaper App",
      home: WallpaperHome(),
    );
  }
}