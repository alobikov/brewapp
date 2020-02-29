import 'package:flutter/material.dart';
import 'package:pushapp/screens/home/setting_form.dart';
import 'package:pushapp/services/auth.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    _showProfileSettings() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsForm()));
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Logout'),
            onTap: () async {
              await _auth.singOut();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              _showProfileSettings();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Abbout'),
            onTap: () {
              _about();
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Close'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

Future<void> _about() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('About'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Android Build'),
              Text('version: 0.0.1'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Close', style: TextStyle(color: Colors.brown[600], fontSize: 18.0 )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
