import 'package:get_it/get_it.dart';
import 'package:my_youtube/services/authentication_service.dart';
import 'package:my_youtube/services/connection_service.dart';
import 'package:my_youtube/services/stream_subscription_handler.dart';
import 'package:my_youtube/services/youtube_service.dart';
import 'package:my_youtube/views/home/home_model.dart';
import 'package:my_youtube/views/player/player_model.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

setUpLocator() {

  //stacked service..
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  //services.
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => StreamSubscriptionHandler());
  locator.registerLazySingleton(() => YoutubeService());
  locator.registerLazySingleton(() => ConnectionService());
  //my models..
  locator.registerLazySingleton(() => HomeModel());
  locator.registerLazySingleton(() => PlayerModel());
}