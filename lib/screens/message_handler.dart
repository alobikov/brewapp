import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/user.dart';
import 'package:pushapp/screens/home/home.dart';
import 'package:pushapp/services/database.dart';

class MessageHandling extends StatefulWidget {
  MessageHandling({Key key}) : super(key: key);

  @override
  _MessageHandlingState createState() => _MessageHandlingState();
}

class _MessageHandlingState extends State<MessageHandling> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // ...
    _saveDeviceToken();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    final user = Provider.of<User>(context, listen: false);
    String fcmToken = await _fcm.getToken();
    try {
      print('atempting to firestore token $fcmToken');
      await DatabaseService(uid: user.uid).updateUserToken(token: fcmToken);
    } catch (e) {
      print('MessageHandling: ${e.toString()}');
    }
    print('MessageHandling ${user.uid}');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
