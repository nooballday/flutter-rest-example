import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Login extends StatelessWidget {
  const Login({
    Key key,
    @required this.onSubmit,
  })
      : super(key: key);

  final VoidCallback onSubmit;

  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _user.text;

  String get password => _pass.text;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.blueAccent),
                borderRadius: new BorderRadius.all(new Radius.circular(10.0))),
            child: new TextField(
              controller: _user,
              decoration:
                  new InputDecoration.collapsed(hintText: "Enter Username"),
            ),
          ),
          new Container(
            margin:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 25.0),
            padding: const EdgeInsets.all(15.0),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.blueAccent),
                borderRadius: new BorderRadius.all(new Radius.circular(10.0))),
            child: new Form(
              child: new TextFormField(
                validator: (val) => val.isEmpty ? 'Tidak boleh kosong' : null,
                controller: _pass,
                decoration:
                    new InputDecoration.collapsed(hintText: "Enter Password"),
                obscureText: true,
              ),
            ),
          ),
          new RaisedButton(
              textColor: Colors.white,
              color: Colors.blueAccent,
              child: new Text("Login"),
              onPressed: onSubmit)
        ],
      ),
    );
  }
}
