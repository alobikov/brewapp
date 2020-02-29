import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/user.dart';
import 'package:pushapp/screens/home/home.dart';
import 'package:pushapp/services/database.dart';
import 'package:pushapp/shared/constants.dart';
import 'package:pushapp/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String _currentName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                title: Text('Profile'),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Update your account name',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        autofocus: true,
                        initialValue: userData.name,
                        decoration: inputTextDecoration,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid)
                                .updateUserName(name: _currentName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
