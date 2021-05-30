import "package:flutter/material.dart";

class ListItems extends StatefulWidget {
  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => MessageBubble(
                text: '${items[index]}',
                sender: "Saurav",
                isMe: true,
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});

  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              elevation: 5.0,
              color: isMe ? Colors.lightBlueAccent : Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      '${text} Title',
                      style: TextStyle(
                          color: isMe ? Colors.white : Colors.black54,
                          fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: isMe ? Colors.white : Colors.black54,
                          fontSize: 15.0),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
