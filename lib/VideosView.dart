import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
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
  int? _value = 1;
  List<Widget> _pages = <Widget>[];


  @override
  Widget build(BuildContext context) {

    _pages.add(new ListView(
      children: getVideos(VideosModel.techniqueVideoIds),
    ));
    _pages.add(new ListView(
      children: getVideos(VideosModel.asmrVideoIds),
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Videos",
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Wrap(
                  children: [
                    ChoiceChip(
                      label: Text('Sleep Techniques'),
                      selected: _value == 1,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 1 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('ASMR'),
                      selected: _value == 2,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 2 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('Sleep Music'),
                      selected: _value == 3,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 3 : null;
                        });
                      },
                    ),
                  ],
                  spacing: 5.0,
                )
              ],
            ),
            Expanded(child: _pages.elementAt(_value! - 1))
          ],
        ));
  }


  List<Widget> getVideos(List<Tuple2> ids) {

    List<YoutubePlayerController> controllers = [];
    for (var v in ids) {
      print(v.item1);
      print(v.item2);
      controllers.add(
        new YoutubePlayerController(
          initialVideoId: v.item2,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ),
      );
    }

    List<YoutubePlayer> players = [];
    for (final c in controllers) {
      players.add(new YoutubePlayer(
        controller: c,
        showVideoProgressIndicator: true,
      ));
    }

    List<Widget> videos = [];
    for (int i = 0; i < players.length; ++i) {
      videos.add(
        new Card(
            color: Colors.black87,
            child: new Text(
              ids[i].item1 + ':',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "WorkSans",
                  color: Colors.white),

            )),
      );

      videos.add(players[i]);
      if (i < players.length - 1) {
        videos.add(SizedBox(
          height: 30,
        ));
      }

    }
    controllers.clear();
    players.clear();
    return videos;
  }

}
