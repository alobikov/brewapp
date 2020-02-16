import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/user.dart';
import 'package:pushapp/screens/authenticate/authenticate.dart';
import 'package:pushapp/screens/home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // return either Authenticate or Home widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}