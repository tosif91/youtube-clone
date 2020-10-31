
import 'dart:convert';

import 'package:my_youtube/models/video_list_item.dart';

VideosData videoItemFromJson(String str) => VideosData.fromJson(json.decode(str));

String videoItemToJson(VideosData data) => json.encode(data.toJson());

class VideosData {
    VideosData({
        this.kind,
        this.etag,
        this.nextPageToken,
        this.regionCode,
        this.pageInfo,
        this.items,
    });

    String kind;
    String etag;
    String nextPageToken;
    String regionCode;
    PageInfo pageInfo;
    List<VideoListItem> items;

    factory VideosData.fromJson(Map<String, dynamic> json) => VideosData(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        regionCode: json["regionCode"],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        items: List<VideoListItem>.from(json["items"].map((x) => VideoListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "nextPageToken": nextPageToken,
        "regionCode": regionCode,
        "pageInfo": pageInfo.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}


class Thumbnails {
    Thumbnails({
        this.thumbnailsDefault,
        this.medium,
        this.high,
    });

    Default thumbnailsDefault;
    Default medium;
    Default high;

    factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromJson(json["default"]),
        medium: Default.fromJson(json["medium"]),
        high: Default.fromJson(json["high"]),
    );

    Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
    };
}

class Default {
    Default({
        this.url,
        this.width,
        this.height,
    });

    String url;
    int width;
    int height;

    factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
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
