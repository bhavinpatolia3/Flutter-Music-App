import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:flutter/material.dart';

class PlayPauseButton extends StatefulWidget {
  double size;
  double height;
  PlayPauseButton({this.size, this.height});

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayerState,
      ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        IconData icon = Icons.music_note;
        Color buttonColor = Colors.white;
        Function onPressed;

        if (player.state == AudioPlayerState.playing) {
          icon = Icons.pause;
          buttonColor = buttonColor;
          onPressed = player.pause;
        } else if (player.state == AudioPlayerState.paused ||
            player.state == AudioPlayerState.idle ||
            player.state == AudioPlayerState.completed ||
            player.state == AudioPlayerState.stopped) {
          icon = Icons.play_arrow;
          buttonColor = Colors.black;
          onPressed = player.play;
        } else if (player.state == AudioPlayerState.loading) {
          icon = Icons.music_note;
        }

        return Container(
          height: widget.height,
          child: RawMaterialButton(
              shape: CircleBorder(),
              fillColor: Colors.black,
              splashColor: Colors.black,
              elevation: 20.0,
              highlightElevation: 5.0,
              child: Icon(
                icon,
                color: Colors.white,
                size: widget.size,
              ),
              onPressed: onPressed),
        );
      },
    );
  }
}
