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
  // final f = new DateFormat('yyyy-MM-dd hh:mm');
  final List<String> dateformat = [yyyy, '-', mm, '-', d, ' ', HH, ':', nn];
  List<Message> _messages = <Message>[];
  final _biggerFont = const TextStyle(fontSize: 20);

  @override
  initState() {
    print('initState() activated');
    dbgBuildMessages().forEach((message) => _messages.add(message));
  }

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    brews.forEach((f) =>
        print('Firestore Snapshot: ${f.name}, ${f.sugars}, ${f.strength}'));

//     ListView.builder(
//       itemCount: brews.length,
//       itemBuilder: (context, index) {
//         return BrewTile(brew: brews[index]);
//       },
//     );
//   }
// Widget _buildMessageList() {
//     return

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.brown[400],
      ),
        padding: const EdgeInsets.all(16.0),
        itemCount: 20,
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(_messages[i]);
        });
  }

  Widget _buildRow(Message message) {
    return ListTile(
      title: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(child: Text(message.from + ': ')), flex: 2),
              Expanded(
                  child: Container(
                      child:
                          Text(message.title, overflow: TextOverflow.ellipsis)),
                  flex: 5),
              Expanded(
                  child: Container(
                    child: Text(
                        formatDate(message.timestamp, dateformat).toString()),
                  ),
                  flex: 4),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: Text(message.body, overflow: TextOverflow.ellipsis)),
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
