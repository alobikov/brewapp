import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/user.dart';
import 'package:pushapp/screens/authenticate/authenticate.dart';
import 'package:pushapp/screens/message_handler.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // each time data arrives from the stream it fires here
    print(user);
    // return either Authenticate if null or Home widget
    if (user == null) {
      return Authenticate();
    } else {
      return MessageHandling();
    }
  }
}

