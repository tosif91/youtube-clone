import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:my_youtube/models/comment_data.dart';
import 'package:my_youtube/models/comment_list_item.dart';
import 'package:my_youtube/models/video_data.dart';
import 'package:my_youtube/models/video_list_item.dart';
import 'package:my_youtube/utils/constants.dart';
import 'package:http/http.dart' as http;

class YoutubeService {
  static const maxResult = 6;
  bool pageExists = false;
  var page = 0;
  var currentIndexPage = 0;
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  
  final StreamController<List<VideoListItem>> _videoStreamController =
      StreamController<List<VideoListItem>>.broadcast();
  VideosData _videosData;
  StreamSubscription _searchDataSubs;
  List<List<VideoListItem>> _allVideoPageRequest = List<List<VideoListItem>>();
  final String _baseUrl =
      'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=$maxResult&type=video&key=$y_api_key';

  
  Future<void> searchVideos({
    String query,
    String pageToken = '',
  }) async {
    List<VideoListItem> videoList = List<VideoListItem>();
    final urlRaw = _baseUrl +
        '&q=$query' +
        (pageToken.isNotEmpty ? '&pageToken=$pageToken' : '');

    final urlEncoded = Uri.encodeFull(urlRaw);

   try{ http.get(urlEncoded,headers: headers).then((response) {
      if (response.statusCode == 200) {
        _videosData = VideosData.fromJson(json.decode(response.body));
        videoList = _videosData.items;

        if (pageExists) {
          _allVideoPageRequest[_allVideoPageRequest.length - 1]
            ..addAll(videoList);
          if (_allVideoPageRequest[_allVideoPageRequest.length - 1].length < 6)
            pageExists = true;
          else
            pageExists = false;
        } else {
          _allVideoPageRequest.add(videoList);
        }

        List<VideoListItem> allVideos =
            _allVideoPageRequest.fold<List<VideoListItem>>(
                List<VideoListItem>(),
                (initialValue, pageItems) => initialValue..addAll(pageItems));

        if (allVideos != null) {
          print('data adde in stream');
          _videoStreamController.add(allVideos);
        } else {
          _videoStreamController.add(null);
        }
      } else {
        _videoStreamController.add(null);
      }
    });
    }
    catch(e){print('got erro $e');};
  }

  Stream<List<VideoListItem>> listenToSearchStream(String text) {
    searchVideos(query: text);
    return _videoStreamController.stream;
  }

  Future<void> loadMoreSearchData(String text) =>
      searchVideos(pageToken: _videosData.nextPageToken, query: text);

  Future<void> newSearchChange(String text) async {
    _allVideoPageRequest.clear();
    pageExists = false;
    page = 0;
    currentIndexPage = 0;
    await searchVideos(query: text);
  }

///////////////////for comment////////////////
  static const maxComment = 10;
  bool pageExistsComment = false;
  var pageComment = 0;
  var currentIndexPageComment = 0;
  final StreamController<List<CommentListItem>> _commentStreamController =
      StreamController<List<CommentListItem>>.broadcast();
  CommentData _commentData;
  StreamSubscription _commentDataSubs;
  List<List<CommentListItem>> _allCommentPageRequest =
      List<List<CommentListItem>>();
  final String _baseCommentUrl =
      'https://youtube.googleapis.com/youtube/v3/commentThreads?part=snippet&maxResults=$maxComment&key=$y_api_key';


  Future<void> commentData({
    String videoId,
    String pageToken = '',
  }) async {
    print('fetching comment data');
    List<CommentListItem> commentList = List<CommentListItem>();
    final urlRaw = _baseCommentUrl +
        '&videoId=$videoId' +
        (pageToken.isNotEmpty ? '&pageToken=$pageToken' : '');

    final urlEncoded = Uri.encodeFull(urlRaw);

    http.get(urlEncoded,headers: headers).then((response) {
      if (response.statusCode == 200) {
      
        _commentData = CommentData.fromJson(json.decode(response.body));
        print(_commentData.items[0]);
        commentList = _commentData.items;

        if (pageExistsComment) {
          _allCommentPageRequest[_allCommentPageRequest.length - 1]
            ..addAll(commentList);
          if (_allCommentPageRequest[_allCommentPageRequest.length - 1].length <
              10)
            pageExistsComment = true;
          else
            pageExistsComment = false;
        } else {
          _allCommentPageRequest.add(commentList);
        }

        List<CommentListItem> allComments =
            _allCommentPageRequest.fold<List<CommentListItem>>(
                List<CommentListItem>(),
                (initialValue, pageItems) => initialValue..addAll(pageItems));

        if (allComments != null) {
          print('data adde in stream');
          _commentStreamController. add(allComments);
        } else {
          _commentStreamController.add(null);
        }
      } else {
        print('gott error in comment process');
        _commentStreamController.add(null);
      }
    });
  }

  Stream<List<CommentListItem>> listenToCommentStream(String videoId) {
    commentData(videoId: videoId);
    return _commentStreamController.stream;
  }

  Future<void> loadMoreCommentData(String videoId) =>
      commentData(pageToken: _commentData.nextPageToken, videoId: videoId);

 clearCommentList(){
   _allVideoPageRequest.clear();
 }

}
