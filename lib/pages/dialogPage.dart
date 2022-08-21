import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class DialogPage extends StatefulWidget {

  final User user;
  final String recipient;


  const DialogPage({required this.user, required this.recipient});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  late String recipientData;
  late User _currentUser;

  var friendName, friendUid, currentUserId, chatDocId;
  final _textController = TextEditingController();


  @override
  void initState(){

    super.initState();
    checkUser();
  }

  void checkUser() async{
    recipientData = widget.recipient;
    _currentUser = widget.user;
    friendName = recipientData.split(',')[2].substring(7);
    friendUid = recipientData.split(',')[0].substring(6);
    // print(widget.recipient);
    // print(friendUid);
    currentUserId = FirebaseAuth.instance.currentUser?.uid;
    // print(currentUserId);
    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            chatDocId = querySnapshot.docs.single.id;
          });

          // print(chatDocId);
        } else {
          await chats.add({
            'users': {currentUserId: null, friendUid: null},
            'names': {currentUserId:FirebaseAuth.instance.currentUser?.displayName,friendUid:friendName }
          }).then((value) {chatDocId = value.id;});
        }
      },
    )
        .catchError((error) {print(error);});
  }

  void sendMessage(String msg){
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'friendName': friendName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chats.doc(chatDocId).collection('messages').orderBy('createdOn', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }


        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          var data;
          return Scaffold(
            appBar: AppBar(
              title: Text('$friendName'),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map(
                            (DocumentSnapshot document) {
                          data = document.data()!;
                          // print(document.toString());
                          // print(data['msg']);
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper6(
                                nipSize: 0,
                                radius: 0,
                                type: isSender(data['uid'].toString())
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble,
                              ),
                              alignment: getAlignment(data['uid'].toString()),
                              margin: const EdgeInsets.only(top: 20),
                              backGroundColor: isSender(data['uid'].toString())
                                  ? const Color(0xFF08C187)
                                  : const Color(0xffE7E7ED),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                  MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(data['msg'],
                                            style: TextStyle(
                                                color: isSender(
                                                    data['uid'].toString())
                                                    ? Colors.white
                                                    : Colors.black),
                                            maxLines: 100,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          data['createdOn'] == null
                                              ? DateTime.now().toString()
                                              : data['createdOn']
                                              .toDate()
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: isSender(
                                                  data['uid'].toString())
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: TextField(
                            controller: _textController,
                          ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send_sharp),
                          onPressed: (){sendMessage(_textController.text);}
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }

      }
    );
  }
}
