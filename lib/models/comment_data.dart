
import 'dart:convert';

import 'package:my_youtube/models/comment_list_item.dart';

CommentData commentDataFromJson(String str) => CommentData.fromJson(json.decode(str));

String commentDataToJson(CommentData data) => json.encode(data.toJson());

class CommentData {
    CommentData({
        this.kind,
        this.etag,
        this.nextPageToken,
        this.pageInfo,
        this.items,
    });

    String kind;
    String etag;
    String nextPageToken;
    PageInfo pageInfo;
    List<CommentListItem> items;

    factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        items: List<CommentListItem>.from(json["items"].map((x) => CommentListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "nextPageToken": nextPageToken,
        "pageInfo": pageInfo.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}


class PageInfo {
    PageInfo({
        this.totalResults,
        this.resultsPerPage,
    });

    int totalResults;
    int resultsPerPage;

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
    );

    Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
    };
}
