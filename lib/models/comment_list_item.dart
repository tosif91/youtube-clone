class CommentListItem {
    CommentListItem({
        this.kind,
        this.etag,
        this.id,
        this.snippet,
    });

    String kind;
    String etag;
    String id;
    ItemSnippet snippet;

    factory CommentListItem.fromJson(Map<String, dynamic> json) =>CommentListItem(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet: ItemSnippet.fromJson(json["snippet"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet.toJson(),
    };
}

class ItemSnippet {
    ItemSnippet({
        this.videoId,
        this.topLevelComment,
        this.canReply,
        this.totalReplyCount,
        this.isPublic,
    });

    String videoId;
    TopLevelComment topLevelComment;
    bool canReply;
    int totalReplyCount;
    bool isPublic;

    factory ItemSnippet.fromJson(Map<String, dynamic> json) => ItemSnippet(
        videoId: json["videoId"],
        topLevelComment: TopLevelComment.fromJson(json["topLevelComment"]),
        canReply: json["canReply"],
        totalReplyCount: json["totalReplyCount"],
        isPublic: json["isPublic"],
    );

    Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "topLevelComment": topLevelComment.toJson(),
        "canReply": canReply,
        "totalReplyCount": totalReplyCount,
        "isPublic": isPublic,
    };
}


class TopLevelCommentSnippet {
    TopLevelCommentSnippet({
        this.videoId,
        this.textDisplay,
        this.textOriginal,
        this.authorDisplayName,
        this.authorProfileImageUrl,
        this.authorChannelUrl,
        this.authorChannelId,
        this.canRate,
        this.viewerRating,
        this.likeCount,
        this.publishedAt,
        this.updatedAt,
    });

    String videoId;
    String textDisplay;
    String textOriginal;
    String authorDisplayName;
    String authorProfileImageUrl;
    String authorChannelUrl;
    AuthorChannelId authorChannelId;
    bool canRate;
    String viewerRating;
    int likeCount;
    DateTime publishedAt;
    DateTime updatedAt;

    factory TopLevelCommentSnippet.fromJson(Map<String, dynamic> json) => TopLevelCommentSnippet(
        videoId: json["videoId"],
        textDisplay: json["textDisplay"],
        textOriginal: json["textOriginal"],
        authorDisplayName: json["authorDisplayName"],
        authorProfileImageUrl: json["authorProfileImageUrl"],
        authorChannelUrl: json["authorChannelUrl"],
        authorChannelId: AuthorChannelId.fromJson(json["authorChannelId"]),
        canRate: json["canRate"],
        viewerRating: json["viewerRating"],
        likeCount: json["likeCount"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "textDisplay": textDisplay,
        "textOriginal": textOriginal,
        "authorDisplayName": authorDisplayName,
        "authorProfileImageUrl": authorProfileImageUrl,
        "authorChannelUrl": authorChannelUrl,
        "authorChannelId": authorChannelId.toJson(),
        "canRate": canRate,
        "viewerRating": viewerRating,
        "likeCount": likeCount,
        "publishedAt": publishedAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class AuthorChannelId {
    AuthorChannelId({
        this.value,
    });

    String value;

    factory AuthorChannelId.fromJson(Map<String, dynamic> json) => AuthorChannelId(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}



class TopLevelComment {
    TopLevelComment({
        this.kind,
        this.etag,
        this.id,
        this.snippet,
    });

    String kind;
    String etag;
    String id;
    TopLevelCommentSnippet snippet;

    factory TopLevelComment.fromJson(Map<String, dynamic> json) => TopLevelComment(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet: TopLevelCommentSnippet.fromJson(json["snippet"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet.toJson(),
    };
}