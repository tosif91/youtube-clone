import 'package:flutter/material.dart';
import 'package:my_youtube/views/login/login_model.dart';
import 'package:stacked/stacked.dart';

class LogInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogInModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => LogInModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, _) => Container(
        child: Center(
          child: (model.isBusy)
              ? CircularProgressIndicator()
              : FlatButton(
                  onPressed: () {}, child: Text('googleSignIn')),
        ),
      ),
    );
  }
}
