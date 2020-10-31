import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_youtube/models/comment_list_item.dart';
import 'package:my_youtube/utils/colors.dart';
//import 'package:optimized_cached_image/optimized_cached_image.dart';

class CommentBox extends StatelessWidget {
  final CommentListItem data;
  CommentBox({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              data.snippet.topLevelComment.snippet.authorDisplayName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              data.snippet.topLevelComment.snippet.textDisplay,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            dense: true,
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 23,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl: data
                        .snippet.topLevelComment.snippet.authorProfileImageUrl,
                    errorWidget: (context, string, _) =>
                        Icon(Icons.error_outlined),
                        placeholder: (context,s)=>Container(color: ltgrey,),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat.yMMMd()
                    .format(data.snippet.topLevelComment.snippet.publishedAt),
                style: TextStyle(fontSize: 10.0, color: Colors.white38),
                textAlign: TextAlign.end,
              ),
            ],
          )
        ],
      ),
    );
  }
}
