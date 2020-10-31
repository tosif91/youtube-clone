

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_youtube/models/video_list_item.dart';
import 'package:my_youtube/utils/colors.dart';
import 'package:my_youtube/utils/styles.dart';

class VideoBox extends StatelessWidget {
  final VideoListItem data;
  final Function handleVideo;
  VideoBox({@required this.data, @required this.handleVideo});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: ltgrey,

      //height: 200,
      child: InkWell(
        onTap: () => handleVideo(data),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              fit: BoxFit.cover,
              height: 150,
              //progressIndicatorBuilder: ,
              // placeholder: (context, _) => CircularProgressIndicator(),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                        backgroundColor: orange,
                        //valueColor: ltgrey,
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),

              width: double.infinity,
              imageUrl: data.snippet.thumbnails.high.url,
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
                title: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    data.snippet.title,
                    style: listheading,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    data.snippet.description,
                    maxLines: 2,
                    style: listsubheading,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
          ],
        ),
      ),
      // child: ListTile(

      //                                   onTap: ()=>handleVideo(data),
      // title:
      //                                   subtitle: Text(data.snippet.channelTitle),
      // leading:
      //                                 ),
    );
  }
}
