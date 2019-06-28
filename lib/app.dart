import 'package:flutter/material.dart';
import 'package:musicplayer/screens/checkinternet.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyPage(),
      ),
    );
  }
}
