import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_tutorial/settings.dart';
import 'package:login_tutorial/login.dart';
import 'dart:io';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _title = "Please Login";
  Widget _screen;
  Login _login;
  Settings _settings;
  bool _authenticated;

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  _MyAppState() {
    _login = new Login(onSubmit: onSubmit);
    _settings = new Settings();
    _screen = _login;
    _authenticated = false;
  }

  void onSubmit() {
    _authUser();
  }

  void _authUser() async {
      var httpClient = new HttpClient();
      var uri = new Uri.http('www.mocky.io', '/v2/5a9ccde03100004f00ab50e3');
      var request = await httpClient.postUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(UTF8.decoder).join();

      Map data = JSON.decode(responseBody);

      String un = data['username'];
      String pw = data['passowrd'];

      print(un+pw);

      if (_login.username == un && _login.password == pw) {
        _setAuthenticated(true);
      } else {
        _scaffoldState.currentState.showSnackBar(
            new SnackBar(content: new Text("Wrong username/password")));
      }
  }

  void _goHome() {
    setState(() {
      if (_authenticated) {
        _screen = _settings;
      } else {
        _screen = _login;
      }
    });
  }

  void _logout() {
    _setAuthenticated(false);
  }

  void _setAuthenticated(bool auth) {
    setState(() {
      _authenticated = auth;
      if (_authenticated) {
        _screen = _settings;
        _title = "Welcome";
      } else {
        _screen = _login;
        _title = "Please Login";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Login Demo",
      home: new Scaffold(
        key: _scaffoldState,
        appBar: new AppBar(
          title: new Text(_title),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.home),
                onPressed: () {
                  _goHome();
                }),
            new IconButton(
                icon: new Icon(Icons.exit_to_app),
                onPressed: () {
                  _logout();
                }),
          ],
        ),
        body: _screen,
      ),
    );
  }
}
