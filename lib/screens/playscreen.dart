import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:musicplayer/screens/songList.dart';
import 'package:musicplayer/screens/songs.dart';
import 'package:musicplayer/screens/widgets/button/PreviousButton/previousButton.dart';
import 'package:musicplayer/screens/widgets/button/next%20button/next_button.dart';
import 'package:musicplayer/screens/widgets/button/playpauseButton/playpause.dart';
import 'package:musicplayer/screens/widgets/progrssbar/circularProgrssbar.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 120.0),
                      height: 500.0,
                      width: 320.0,
                      child: AudioPlaylistComponent(
                        playlistBuilder: (BuildContext context,
                            Playlist playlist, Widget child) {
                          return AudioRadialSeekBar();
                        },
                      )),
                ),
                AppBar(
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SongList()));
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 35.0,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      color: Colors.black,
                      icon: Icon(
                        Icons.short_text,
                        textDirection: TextDirection.rtl,
                        size: 35.0,
                      ),
                      onPressed: () {},
                    )
                  ],
                  backgroundColor: Colors.transparent,
                ),
                AudioPlaylistComponent(
                  playlistBuilder:
                      (BuildContext context, Playlist playlist, Widget child) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(''),
                                  Text(''),
                                  Text(
                                    ('${demoPlaylist.songs[playlist.activeIndex].songTitle}'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              height: 500.0,
                              width: 250.0,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 20.0,
                                    )
                                  ],
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${demoPlaylist.songs[playlist.activeIndex].albumArtUrl}')),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(150.0))),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            Container(
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.shuffle),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            ),
                            Container(
                              height: 50.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[PreviousButton()],
                                  ),
                                  Column(
                                    children: <Widget>[NextButton()],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.repeat),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: PlayPauseButton(
                      size: 40.0,
                      height: 70.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
