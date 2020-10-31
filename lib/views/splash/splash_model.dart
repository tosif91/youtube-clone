import 'package:my_youtube/locator.dart';
import 'package:my_youtube/services/authentication_service.dart';
import 'package:my_youtube/services/connection_service.dart';
import 'package:my_youtube/utils/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashModel extends BaseViewModel {
final ConnectionService _connectionService=locator<ConnectionService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void handleNavigation() {
   initialization();
    _navigationService.clearStackAndShow(home);
   }

 initialization(){
 _connectionService.initialize();
 }

}
