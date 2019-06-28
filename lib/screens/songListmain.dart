import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:musicplayer/screens/songList.dart';
import 'package:musicplayer/screens/songs.dart';

class StlsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StlsListState();
  }
}

class StlsListState extends State<StlsList> {
  final PlaybackState playbackState = PlaybackState.paused;
  Widget build(BuildContext context) {
    return AudioPlaylist(
      playlist: demoPlaylist.songs.map((DemoSong song) {
        return song.audioUrl;
      }).toList(),
      playbackState: playbackState,
      child: SongList(),
    );
  }
}
