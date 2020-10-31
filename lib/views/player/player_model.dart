import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_youtube/locator.dart';
import 'package:my_youtube/models/comment_list_item.dart';
import 'package:my_youtube/models/video_list_item.dart';
import 'package:my_youtube/services/connection_service.dart';
import 'package:my_youtube/services/youtube_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerModel extends BaseViewModel {
  VideoListItem _videoData;
  YoutubePlayerController controller;
  final YoutubeService _youtubeService = locator<YoutubeService>();
  StreamSubscription _commentStreamSubscription, _connectionSubscription;
  List<CommentListItem> commentList = List<CommentListItem>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  bool _isConnected;
  final ConnectionService _connectionService = locator<ConnectionService>();
  ScrollController _controller;
  bool isFetching = false;

  initialize(VideoListItem item) {
    _videoData = item;

    controller = YoutubePlayerController(
      initialVideoId: item.id.videoID,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    listenConnection();
    listenToComment();
  }

  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _controller.value.playerState;
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }

  listController(ScrollController controller) {
    _controller = controller;
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        print('reach bottom');
        moreCommentDataRequest();
      }
      if (controller.offset <= controller.position.minScrollExtent &&
          !controller.position.outOfRange) {
        print('reach top');
      }
    });
  }

  listenConnection() {
    _isConnected = _connectionService.hasConnection;
    // print(_isConnected);
    notifyListeners();

    _connectionSubscription =
        _connectionService.connectionChange.listen((event) {
      _isConnected = event;
      notifyListeners();
    });
  }

  listenToComment() {
    print('inside comment stream');
    print(_videoData.id.videoID);
    _commentStreamSubscription = _youtubeService
        .listenToCommentStream(_videoData.id.videoID)
        .listen((data) {
      if (data != null) {
        commentList = data;
        notifyListeners();
      } else
        print('no comment data');
    });
  }

  moreCommentDataRequest() async {
    // print(isFetching);
    if (_isConnected) {
      if (!isFetching) {
        setFetchingState(true);
        await _youtubeService.loadMoreCommentData(_videoData.id.videoID);

        setFetchingState(false);
      }
    } else {
      _snackbarService.showSnackbar(
          message: 'no internet,check your network connection');
    }
  }

  void setFetchingState(bool value) {
    isFetching = value;
    notifyListeners();
  }

  void resetFields() {
    commentList.clear();
    isFetching = false;
 //   _videoData = null;
    controller.reset();
  }

  void cancelSubscriptions() {
    _connectionSubscription.cancel();
    _commentStreamSubscription.cancel();
  }

  @override
  void dispose() {
    _youtubeService.clearCommentList();
    print('disposeing player');
    resetFields();
    cancelSubscriptions();
    //  super.dispose();
  }
}
