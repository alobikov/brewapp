import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class FcmUsersList extends StatefulWidget {
  FcmUsersList() : super();

  final String title = "FcmUsersList Demo";

  @override
  DropDownState createState() => DropDownState();
}

class FcmUsers {
  final users = Map<String, String>();

  addUser({String name, String token}) {
    users[name] = token;
  }
}

class DropDownState extends State<FcmUsersList> {
  var fcmUsers = FcmUsers();
  String dropdownValue;
  TextEditingController _controller;
  String _enteredMessage;

  _makeUsersList(FcmUsers fcmUsers, snapshot) {
    for (var doc in snapshot.data.documents)
      fcmUsers.addUser(name: doc['name'], token: doc['token']);
  }

  void createRecord(String message, String title, String token) async {
    DocumentReference ref =
        await Firestore.instance.collection("messages").add({
      'message': message,
      'token': token,
      'title': title,
    });
    print(ref.documentID);
    print('Sending to token: $token');
  }

  @override
  void initState() {
    _controller = TextEditingController();
    print('initState in fcm_users_list');
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        title: Text("Send Notification Message"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: Firestore.instance.collection('brews').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Text('Loading data... Please wait...');
              _makeUsersList(fcmUsers, snapshot);
              print('_nakeUsersList evoked!');
              dropdownValue = fcmUsers.users.entries.toList()[0].value;
              // _dropdownMenuItems = buildDropdownMenuItems(fcmUsers.users);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Send to:", style: TextStyle(fontSize: 16)),
                      SizedBox(
                        width: 20.0,
                      ),
                      // Text('test'),
                      // Text(fcmUsers.users.toString()),

                      DropdownButton<String>(
                        items: fcmUsers.users
                            .map((name, value) {
                              return MapEntry(
                                  name,
                                  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(name),
                                  ));
                            })
                            .values
                            .toList(),
                        value: dropdownValue,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            print(dropdownValue);
                          });
                        },
                      ),
                    ],
                  ),
                  Text('Message:', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.white,
                    child: TextField(
                      controller: _controller,
                      onChanged: ((String value) => _enteredMessage = value),
                      maxLines: 3,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RaisedButton(
                      child: Text('Send'),
                      onPressed: () {
                        createRecord(_enteredMessage,'Title', dropdownValue);
                        Navigator.pop(context);
                        },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
