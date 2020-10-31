import 'package:flutter/material.dart';
import 'package:my_youtube/locator.dart';
import 'package:my_youtube/models/video_list_item.dart';
import 'package:my_youtube/utils/styles.dart';
import 'package:my_youtube/views/player/player_model.dart';
import 'package:my_youtube/widgets/comment_box.dart';
//import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerView extends StatelessWidget {
  final VideoListItem item;
  PlayerView({@required this.item});
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ViewModelBuilder<PlayerModel>.reactive(
          viewModelBuilder: () => locator< PlayerModel>(),
          onModelReady: (model) {
            model.initialize(item);
            model.listController(_controller);
          },
          builder: (context, model, _) => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoutubePlayer(
                  controller: model.controller,
                  bufferIndicator: CircularProgressIndicator(),
                  
                  // showVideoProgressIndicator: true,
                  // videoProgressIndicatorColor: Colors.amber,
                  // progressColors: ProgressColors(
                  //     playedColor: Colors.amber,
                  //     handleColor: Colors.amberAccent,
                  // ),
                  // onReady () {
                  //     _controller.addListener(listener);
                  // },
                ),
                
                Text(
                  'Comments',
                  style: heading,
                  textAlign: TextAlign.start,
                ),
                (model.commentList?.isEmpty == true)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _controller,
                          itemCount: model.commentList?.length,
                          itemBuilder: (context, index) =>
                              CommentBox(data: model.commentList[index]),
                        ),
                      ),
                (model.isFetching)
                    ? Container(
                        height: 35.0,
                        width: double.infinity,
                        child: Text('fetching more...'),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
