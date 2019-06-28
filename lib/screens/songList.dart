import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:musicplayer/screens/playscreen.dart';
import 'package:musicplayer/screens/songs.dart';
import 'package:musicplayer/screens/widgets/button/PreviousButton/previousButton.dart';
import 'package:musicplayer/screens/widgets/button/next%20button/next_button.dart';
import 'package:musicplayer/screens/widgets/button/playpauseButton/playpause.dart';

class SongList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SongListState();
  }
}

class SongListState extends State<SongList> {
  int index;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: <Widget>[
            Stack(
              children: [
                AudioPlaylistComponent(
                  playlistBuilder:
                      (BuildContext context, Playlist playlist, Widget child) {
                    return Container(
                      child: Center(
                        child: Container(
                          height: 400.0,
                          width: 250.0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10.0,
                                )
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/image/timothy-rose-nBaf7c_wd80-unsplash.jpg')),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(150.0))),
                        ),
                      ),
                    );
                  },
                ),
                AppBar(
                  elevation: 0.0,
                  actions: <Widget>[
                    IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.short_text,
                          textDirection: TextDirection.rtl, size: 35.0),
                      onPressed: () {},
                    )
                  ],
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            AudioPlaylistComponent(
              playlistBuilder:
                  (BuildContext context, Playlist playlist, Widget child) {
                return Flexible(
                  child: ListView.builder(
                    itemCount: demoPlaylist.songs.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        onTap: () {
                          playlist.listChange(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PlayScreen()));
                          print(playlist.activeIndex);
                        },
                        title: Text(
                          demoPlaylist.songs[index].songTitle,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(demoPlaylist.songs[index].artist),
                        contentPadding:
                            EdgeInsets.only(left: 75.0, right: 75.0),
                        trailing: Text(
                          demoPlaylist.songs[index].time,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shuffle),
                ),
                PreviousButton(),
                PlayPauseButton(
                  size: 20.0,
                  height: 30.0,
                ),
                NextButton(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.repeat),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
