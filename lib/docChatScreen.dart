import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tib_talash/constants.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class chatScreen extends StatefulWidget {
  static const chatScreenID = 'chat_screen';
  chatScreen(this.id, this.name, this.url);
  final String id;
  final String name;
  final String url;
  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {

  String userMessage = '';
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        title: Text('${widget.name}', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.white),),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, size: 35.0,), color: Colors.white,),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.video_call_outlined, size: 35.0, color: Colors.white,)),
        ],
      ),
      body: SafeArea(
          child: Column(
            children: [
              chat(widget.id),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          userMessage = value;
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(suffixIcon: IconButton(
                          icon: Icon(Icons.send, color: primColor,),
                          onPressed: () {
                            if(userMessage == ''){
                              null;
                            }
                            else {
                              messageTextController.clear();
                              _firestore.collection('doctors_data').doc('$Myid').collection('chats').doc('${widget.id}').collection('chat').add({
                                "sender_id": Myid,
                                "message": userMessage,
                                "time": DateTime.now(),
                              });
                              setState((){
                                userMessage = '';
                              });
                            }
                          },
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ]
      )
    ),
    );
  }
}
class chat extends StatelessWidget {

  chat(this.id);
  final String id;
  
  @override
  Widget build(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('doctors_data').doc(
              Myid).collection('chats').doc('$id').collection(
              'chat').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: primColor,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Loading Messages ...', style: TextStyle(fontSize: 10.0),)
                  ],
                ),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/no_messages.png'),
                      height: 70,
                      width: 70,),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('No Messages', style: TextStyle(fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),)
                  ],
                ),
              );
            }
            List <MessageBubble> messageBubble = [];
            final messages = snapshot.data!.docs.reversed;
            for(var message in messages){
              final sender = message.get('sender_id');
              final text = message.get('message');
              final time = message.get('time');

              final messagebubble = MessageBubble(
                sender,
                text,
                time
              );
              messageBubble.add(messagebubble);
              messageBubble.sort((a,b) => b.time.compareTo(a.time));
            }
            return Expanded(
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                  children: messageBubble,
                )
            );
          }
      );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(this.sender, this.text, this.time);

  final String sender;
  final String text;
  final Timestamp time;
  bool isMe(){
    if(sender == Myid){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe() ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe() ? primColor : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe() ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
