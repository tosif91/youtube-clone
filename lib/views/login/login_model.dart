import 'dart:async';


import 'package:flutter/material.dart';
import 'package:my_youtube/locator.dart';
import 'package:my_youtube/services/authentication_service.dart';
import 'package:my_youtube/services/connection_service.dart';
import 'package:my_youtube/utils/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LogInModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final ConnectionService _connectionService = locator<ConnectionService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  StreamSubscription _connectionSubscription;
  bool _isConnected=true;

  initialize() {
    listenConnection();
  }

  listenConnection() {
    //_isConnected = _connectionService.hasConnection;
//print(_isConnected);
    notifyListeners();
    _connectionSubscription =
        _connectionService.connectionChange.listen((event) {
      _isConnected = event;
      notifyListeners();
     
    });
     print(_isConnected);
  }

  // signIn() async {
  //   if (_isConnected) {
  //     setBusy(true);
  //     User result = await _authenticationService.handleGoogleSignIn();
  //     if (result != null) {
  //       setBusy(false);
  //       _navigationService.clearStackAndShow(home);
  //     } else {
  //       _dialogService.showDialog(
  //           title: 'error', description: 'sigIn failed, Please try Again.');
  //       setBusy(false);
  //     }
  //   } else {
  //     _snackbarService.showSnackbar(
  //         message: 'no internet,check you network connection',
  //         duration: Duration(seconds: 3));
  //   }
  // }
}
