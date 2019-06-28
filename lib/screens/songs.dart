import 'package:meta/meta.dart';

final demoPlaylist = new DemoPlaylist(
  songs: [
    new DemoSong(
      audioUrl:
          'https://api.soundcloud.com/tracks/434370309/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl:
          'https://images.unsplash.com/photo-1461988320302-91bde64fc8e4?ixid=2yJhcHBfaWQiOjEyMDd9&fm=jpg&fit=crop&w=1080&q=80&fit=max',
      songTitle: 'Perfect Saxophone',
      artist: 'Simon More',
      time: '5:25',
    ),
    new DemoSong(
      audioUrl:
          'https://api.soundcloud.com/tracks/402538329/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl:
          'https://images.unsplash.com/photo-1449614115178-cb924f730780?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max',
      songTitle: 'Let You Down',
      artist: 'Kumbor',
      time: '3:26',
    ),
    new DemoSong(
      audioUrl:
          'https://api.soundcloud.com/tracks/266891990/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl:
          'https://images.unsplash.com/photo-1461988320302-91bde64fc8e4?ixid=2yJhcHBfaWQiOjEyMDd9&fm=jpg&fit=crop&w=1080&q=80&fit=max',
      songTitle: 'Electro Monotony',
      artist: 'Nights & Weekends',
      time: '4:15',
    ),
    new DemoSong(
      audioUrl:
          'https://api.soundcloud.com/tracks/260578593/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl:
          'https://images.unsplash.com/1/type-away.jpg?q=80&fm=jpg&w=1080&fit=max',
      songTitle: 'Debut Trance',
      artist: 'Nights & Weekends',
      time: '2:29',
    ),
    new DemoSong(
      audioUrl:
          'https://api.soundcloud.com/tracks/258735531/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl:
          'https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=92f3e02f63678acc8416d044e189f515',
      songTitle: 'Debut',
      artist: 'Nights & Weekends',
      time: '2:59',
    ),
    new DemoSong(
      audioUrl:
          'https://api.soundcloud.com/tracks/9540352/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl:
          'https://images.unsplash.com/photo-1454625233598-f29d597eea1e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max',
      songTitle: 'Assn1-tribal-beat',
      artist: 'Matt',
      time: '3:57',
    ),
  ],
);

class DemoPlaylist {
  final List<DemoSong> songs;

  DemoPlaylist({
    @required this.songs,
  });
}

class DemoSong {
  final String audioUrl;
  final String albumArtUrl;
  final String songTitle;
  final String artist;
  final String time;

  DemoSong({
    this.audioUrl,
    this.albumArtUrl,
    this.songTitle,
    this.artist,
    this.time,
  });
}
