import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

class PreviousButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(
      playlistBuilder: (BuildContext context, Playlist playlist, Widget child) {
        return IconButton(
          onPressed: () {
            playlist.previous();
          },
          icon: Icon(Icons.skip_previous),
        );
      },
    );
  }
}
