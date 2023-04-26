import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:units/AppColors.dart';
import 'package:units/models/VideosModel.dart';
import 'package:units/presenters/CalculatorPresenter.dart';
import 'package:units/views/CalculatorView.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
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
  YoutubePlayerController _controller = new YoutubePlayerController(
      initialVideoId: VideosModel.techniqueVideoIds[0].item2,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      )
  );


  @override
  Widget build(BuildContext context) {
    _pages.add(new ListView(
        children: getVideos(VideosModel.techniqueVideoIds),
      ),
    );
    _pages.add(new ListView(
      children: getVideos(VideosModel.asmrVideoIds),
    ),
    );
    _pages.add(new ListView(
      children: getVideos(VideosModel.musicVideoIds),
    ),
    );

    return Scaffold(
      backgroundColor: AppColors.dark,
        appBar: AppBar(
          title: Text(
            "Videos",
          ),
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
            ),
            Row(
              children: [
                Wrap(
                  children: [
                    ChoiceChip(
                      label: Text('Sleep Techniques'),
                      selectedColor: Colors.deepPurpleAccent.shade100,

                      selected: _value == 1,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 1 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('ASMR'),
                      selectedColor: Colors.deepPurpleAccent.shade100,

                      selected: _value == 2,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 2 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: Text('Sleep Music'),
                      selectedColor: Colors.deepPurpleAccent.shade100,
                      selected: _value == 3,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 3 : null;
                        });
                      },
                    ),
                  ],
                  spacing: 5.0,
                ),
              ],
            ),
            Expanded(child: _pages.elementAt(_value! - 1)),
          ],
        ));
  }

  List<Widget> getVideos(List<Tuple2> ids) {
    List<Widget> videos = [];

    for (var video in ids) {
      videos.add(
          GestureDetector(
        onTap: () {
          _controller.load(video.item2);
        },
        child:
        Card(
          color: AppColors.dark,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.secondary,
              ),
              borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
            ),

          child: Container(

            child: Row(
              children: [
                Icon(Icons.play_arrow_outlined,
                  size: 40,
                    color: AppColors.secondary
                  ),
                Expanded(
                  child:
                  Text(
                    video.item1,
                    style: TextStyle(
                      //color: Colors.white,
                      fontFamily: "WorkSans",
                      fontSize: 25,
                      color: AppColors.accentLight
                    ),
                  ),

                ),

              ],
            ),
          )

        ),
      ));

    }

    return videos;
  }
}
