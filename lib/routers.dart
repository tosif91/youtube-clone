import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_youtube/utils/routes.dart';
import 'package:my_youtube/views/home/home_view.dart';
import 'package:my_youtube/views/login/login_view.dart';
import 'package:my_youtube/views/player/player_view.dart';
import 'package:my_youtube/views/splash/splash_view.dart';

class Routers {
  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => SplashView());
      case home:
        return MaterialPageRoute(builder: (context) => HomeView());
      case login:
        return MaterialPageRoute(builder: (context) => LogInView());
        case player:
        return MaterialPageRoute(builder: (context) => PlayerView(item: settings.arguments,));
      default:
        return MaterialPageRoute(
            builder: (context) => Container(
                  alignment: Alignment.center,
                  child: Text('Invalid Route'),
                ));
    } //switch
  }
}
