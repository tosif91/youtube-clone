
import 'package:flutter/material.dart';
import 'package:my_youtube/locator.dart';
import 'package:my_youtube/routers.dart';
import 'package:my_youtube/views/splash/splash_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
           return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'youtube',
              theme: ThemeData.dark(),
              home: SplashView(),
              //this parameter for navigation service
              navigatorKey: locator<NavigationService>().navigatorKey,
              onGenerateRoute: Routers.toGenerateRoute,
            );
  }
}