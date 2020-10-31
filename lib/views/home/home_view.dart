import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_youtube/locator.dart';
import 'package:my_youtube/utils/colors.dart';
import 'package:my_youtube/views/home/home_model.dart';
import 'package:my_youtube/widgets/video_box.dart';
//import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ViewModelBuilder<HomeModel>.reactive(
          fireOnModelReadyOnce: true,
          viewModelBuilder: () => locator<HomeModel>(),
          //   disposeViewModel: false,
          onModelReady: (model) {
            model.listController(_scrollController);
            model.initialize(_controller);
          },
          builder: (context, model, _) => Container(
            decoration: background,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: model.isConnected,
                    maxLines: 1,
                    controller: _controller,
                    //  onChanged: (value) => model.searchResult(value),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'search here'),
                  ),
                ),

                Expanded(
                  child: (!model.isConnected)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.network_check_outlined,
                              size: 40,
                            ),
                            Text(
                              'oops,no internet check you network connection',
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      : (model.initialState)
                          ? Center(child: Text('lets begin search'))
                          : (model.isBusy)
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  itemCount: model.videos.length,
                                  itemBuilder: (context, index) => VideoBox(
                                      data: model.videos[index],
                                      handleVideo: (data) =>
                                          model.handleVideo(data))),
                ),
                Visibility(
                    visible: model.isFetching,
                    child: Center(
                      child: CircularProgressIndicator(),
                    )),
                // FlatButton(
                //       onPressed: () => model.searchResult(_controller.text),
                //       child: Text('search'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
