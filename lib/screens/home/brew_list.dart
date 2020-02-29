import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/brew.dart';
import 'package:pushapp/models/message.dart';
import 'package:pushapp/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  Messages _msg = Messages.instance;
  // final f = new DateFormat('yyyy-MM-dd hh:mm');
  final List<String> dateformat = [yyyy, '-', mm, '-', d, ' ', HH, ':', nn];

  @override
  initState() {
    print('initState() activated');
    // dbgBuildMessages().forEach((message) => _messages.add(message));
  }

  @override
  Widget build(BuildContext context) {
    // final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.brown[400],
      ),
        padding: const EdgeInsets.all(16.0),
        itemCount: null == _msg.messages ? 0 : _msg.messages.length,
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(_msg.messages[i]);
        });
  }

  Widget _buildRow(Message message) {
    return ListTile(
      title: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(child: Text('From Aleks: ')), flex: 4),
              Expanded(
                  child: Container(
                      child:
                          Text(message.title ?? 'Empty', overflow: TextOverflow.ellipsis)),
                  flex: 5),
              Expanded(
                  child: Container(
                    child: Text('2020-20-02'),
                        // formatDate(message.timestamp, dateformat).toString()),
                  ),
                  flex: 4),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: Text(message.message ?? 'Empty', overflow: TextOverflow.ellipsis)),
            ],
          )
        ],
      ),
    );
  }

  Iterable<Message> dbgBuildMessages() sync* {
    for (var i = 0; i < 20; i++) {
      yield Message(
          from: 'Aleks',
          title: 'message$i',
          body: 'Hi, Melania: lorem ipsum monoflipsum dearum unitas extras',
          timestamp: DateTime.now());
    }
  }
}
