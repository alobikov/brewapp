import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/screens/wrapper.dart';
import 'package:pushapp/services/auth.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Push App',
        color: Colors.brown[600],
        home: Wrapper(),
        // home: Text('HI'),
      ),
    );
  }
}
