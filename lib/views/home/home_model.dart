import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_youtube/locator.dart';
import 'package:my_youtube/models/video_data.dart';
import 'package:my_youtube/models/video_list_item.dart';
import 'package:my_youtube/services/connection_service.dart';
import 'package:my_youtube/services/youtube_service.dart';
import 'package:my_youtube/utils/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeModel extends BaseViewModel {
  List<VideoListItem> _videoList = List<VideoListItem>();
  bool _isConnected;
  get isConnected => _isConnected;
  bool initialState = true;
  final YoutubeService _youtubeService = locator<YoutubeService>();
  final ConnectionService _connectionService = locator<ConnectionService>();
  StreamSubscription _connectionSubscription, _searchStreamSubscription;
  List<VideoListItem> get videos => _videoList;
  ScrollController _controller;
  bool isFetching = false;
  final NavigationService _navigationService = locator<NavigationService>();
//  final StreamController<String> streamController=StreamController();
  TextEditingController _searchQuery = new TextEditingController();
  Timer _debounce;
  String tempSearch = '';
  initialize(TextEditingController controller) {
    print('initializing homeview');
    _searchQuery = controller;
    listenConnection();
    _searchQuery.addListener(() => _validateValues());
  }

  _validateValues() {
    String searchText = _searchQuery.text.trim();
    if (searchText.length >= 3) {
      if (tempSearch.length != searchText.length) {
        tempSearch = searchText;
        _onSearchChanged();
      } else {
        print('no change or only whitespace');
      }
    } else {
      print('length < 3');
    }
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      print('called search query');
      searchResult(_searchQuery.text);
    });
  }


  listController(ScrollController controller) {
    _controller = controller;
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        print('reach bottom');
        moreSearchDataRequest();
      }
      if (controller.offset <= controller.position.minScrollExtent &&
          !controller.position.outOfRange) {
        print('reach top');
      }
    });
  }

  moreSearchDataRequest() async {
    print(isFetching);
    if (!isFetching) {
      setFetchingState(true);
      await _youtubeService.loadMoreSearchData(_searchQuery.text.trim());

      setFetchingState(false);
    }
  }

  void setFetchingState(bool value) {
    isFetching = value;
    notifyListeners();
  }

  listenConnection() {
    _isConnected = _connectionService.hasConnection;
    notifyListeners();
 _connectionSubscription =
        _connectionService.connectionChange.listen((event) {
      _isConnected = event;
      notifyListeners();
    });
  }

  searchResult(String text) async {
    if (initialState) {
      initialState = false;
      setBusy(true);
      _youtubeService.listenToSearchStream(text).listen((data) {
        if (data != null) {
          _videoList = data;
          if (_searchQuery.text.trim().isEmpty) _videoList.clear();
          setBusy(false);
          notifyListeners();
        } else {
          setBusy(false);
          print('data not found');
        }
      });
    } else {
      _videoList.clear();
      setBusy(true);
      await _youtubeService
          .newSearchChange(text)
          .then((value) => setBusy(false));
    }
  }

  handleVideo(VideoListItem videoListItem) {
    FocusManager.instance.primaryFocus.unfocus();
    _navigationService.navigateTo(player, arguments: videoListItem);
  }

  @override
  void dispose() {
   print('called dispose homemodel');
    _searchQuery.removeListener(_onSearchChanged());
    _searchQuery.clear();
    _controller.dispose();
    _searchQuery.dispose();
  _connectionSubscription.cancel();
   _searchStreamSubscription.cancel();
    super.dispose();
  }
}
