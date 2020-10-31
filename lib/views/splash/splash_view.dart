import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_youtube/utils/colors.dart';
import 'package:my_youtube/utils/styles.dart';
import 'package:my_youtube/views/splash/splash_model.dart';
class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
final SplashModel _model=SplashModel();
@override
  void initState() {
    Timer(Duration(milliseconds: 1500), (){
      _model.handleNavigation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            decoration: background,
        child: Center(child: const Text('My Youtube',style: heading1,),),
      ),
    );
  }
}