import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tuple/tuple.dart';

class VideosModel {

  // title, videoID
  static const List<Tuple2<String, String>> techniqueVideoIds = [
    const Tuple2("Mayo Clinic Minute: Tips for Better Sleep", "s2lwUIKsRWg"),
    const Tuple2("6 tips for better sleep | Sleeping with Science, a TED series", "t0kACis_dJE"),
    const Tuple2("5 Tips For Falling Asleep Quicker, According To A Sleep Expert", "ZKNQ6gsW45M"),
    const Tuple2("Proven Sleep Tips | How To Fall Asleep Faster", "m2SVFx2mOEg")
  ];

  static const List<Tuple2<String, String>> asmrVideoIds = [
    const Tuple2("SATISFYING VIDEO TO RELAX, CALM & PUT THE BRAIN TO SLEEP 🧠😴", "zmbZ5klT2"),
    const Tuple2("Satisfying Slime ASMR | Relaxing Slime Videos # 1128", "NZiM0_4-j1k")
  ];

}
