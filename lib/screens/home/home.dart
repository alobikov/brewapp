import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/brew.dart';
import 'package:pushapp/screens/home/brew_list.dart';
import 'package:pushapp/screens/home/setting_form.dart';
import 'package:pushapp/services/auth.dart';
import 'package:pushapp/services/database.dart';

class Home extends StatelessWidget {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Push App'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              label: Text('logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.singOut();
                print('In home.dart _auth: ${_auth.hashCode}');
              },
              icon: Icon(Icons.person, color: Colors.white),
            ),
            FlatButton.icon(
              label: Text('settings', style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () => _showSettingsPanel(),
              ),
          ],
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/coffee_bg.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: BrewList(),
        ),
      ),
    );
  }
 
  

}
