import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:units/models/VideosModel.dart';
import 'package:units/presenters/SettingsPresenter.dart';
import 'contracts/settings_contract.dart';
import 'Authentication.dart';
import 'main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideosStatefulWidget(key: super.key),
    );
  }
}

class VideosStatefulWidget extends StatefulWidget {
  VideosStatefulWidget({super.key});

  @override
  State<VideosStatefulWidget> createState() => _VideosStatefulWidgetState();
}

class _VideosStatefulWidgetState extends State<VideosStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final List<YoutubePlayerController> controllers = [];

    for (var v in VideosModel.videoIds) {
      controllers.add(
        YoutubePlayerController(
          initialVideoId: v.item2,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ),
      );
    }

    late List<YoutubePlayer> players = <YoutubePlayer>[];
    for (final c in controllers) {
      players.add(new YoutubePlayer(
        controller: c,
        showVideoProgressIndicator: true,
      ));
    }

    List<Widget> videosPage = [];
    for (int i = 0; i < players.length; ++i) {
      videosPage.add(new Text(
        VideosModel.videoIds[i].item1,
        style: TextStyle(fontSize: 30),
      ));
      videosPage.add(players[i]);
      if (i < players.length - 1) {
        videosPage.add(SizedBox(height: 15,));
      }
    }

    var videosListView = new ListView(
      children: videosPage,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Videos",
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: videosListView);
  }
}
