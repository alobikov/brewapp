import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/brew.dart';
import 'package:pushapp/screens/home/brew_list.dart';
import 'package:pushapp/screens/home/drawer.dart';
import 'package:pushapp/screens/home/fcm_users_list.dart';
import 'package:pushapp/services/auth.dart';
import 'package:pushapp/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

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
              label: Text('Send Message', style: TextStyle(color: Colors.white)),
              onPressed: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FcmUsersList()));
              },
              icon: Icon(Icons.message, color: Colors.white),
            ),
          ],
        ),
        drawer: AppDrawer(),
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




