
import 'dart:convert';

VideoListItem videoListItemFromJson(String str) => VideoListItem.fromJson(json.decode(str));

String videoListItemToJson(VideoListItem data) => json.encode(data.toJson());

class VideoListItem {
    VideoListItem({
        this.kind,
        this.etag,
        this.id,
        this.snippet,
    });

    String kind;
    String etag;
    Id id;
    Snippet snippet;

    factory VideoListItem.fromJson(Map<String, dynamic> json) => VideoListItem(
        kind: json["kind"],
        etag: json["etag"],
        id: Id.fromJson(json["id"]),
        snippet: Snippet.fromJson(json["snippet"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id.toJson(),
        "snippet": snippet.toJson(),
    };
}

class Id {
    Id({
      this.videoID,
        this.kind,
        this.channelId,
    });
    String videoID;
    String kind;
    String channelId;

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        kind: json["kind"],
        channelId: json["channelId"],
        videoID: json['videoId'],
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "channelId": channelId,
    };
}

class Snippet {
    Snippet({
        this.publishedAt,
        this.channelId,
        this.title,
        this.description,
        this.thumbnails,
        this.channelTitle,
        this.liveBroadcastContent,
        this.publishTime,
    });

    DateTime publishedAt;
    String channelId;
    String title;
    String description;
    Thumbnails thumbnails;
    String channelTitle;
    String liveBroadcastContent;
    DateTime publishTime;

    factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        liveBroadcastContent: json["liveBroadcastContent"],
        publishTime: DateTime.parse(json["publishTime"]),
    );

    Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails.toJson(),
        "channelTitle": channelTitle,
        "liveBroadcastContent": liveBroadcastContent,
        "publishTime": publishTime.toIso8601String(),
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
    });

    String url;

    factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
