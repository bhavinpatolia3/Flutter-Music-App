import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/screens/songListmain.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _tryAgain = false;

  @override
  void initState() {
    super.initState();
    _checkWifi();
  }

  _checkWifi() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    bool connectedToWifi = (connectivityResult == ConnectivityResult.wifi);
    bool mobileData = (connectivityResult == ConnectivityResult.mobile);
    if (!connectedToWifi && !mobileData) {
      _showAlert(context);
    }

    if (_tryAgain != !connectedToWifi && !mobileData) {
      setState(() {
        _tryAgain = !connectedToWifi;
        _tryAgain = !mobileData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Container(
      alignment: Alignment.center,
      child: _tryAgain ? Text("Try again") : StlsList(),
    );

    return Scaffold(body: StlsList());
  }

  void _showAlert(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ], content: Text("Check your internet Connection")));
  }
}
