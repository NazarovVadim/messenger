import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/pages/dialogPage.dart';
import 'package:chat_app/states/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChatsPage extends StatefulWidget {
  final User user;

  const ChatsPage({required this.user});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    chatState.refreshChatsForCurrentUser();
    super.initState();

  }

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DialogPage(user: _currentUser, recipientName: name, recipientUid: uid,)));
  }

  @override
  Widget build(BuildContext context) {
  if(chatState.messages.isNotEmpty){
    return Observer(builder: (BuildContext context) => CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text("Chats"),
        ),
        SliverList(
            delegate: SliverChildListDelegate(

                chatState.messages.values.toList().map((data) {

                  dynamic friendName = data['friendName'][0].toString().toUpperCase() + data['friendName'].toString().substring(1);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(friendName[0], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                      radius: 30,
                      backgroundColor: Colors.deepOrangeAccent,
                    ),
                    title: Text(friendName, style: TextStyle(fontWeight: FontWeight.w700),),
                    subtitle: Text(data['msg']),
                    onTap: () => callChatDetailScreen(
                        context, data['friendName'], data['friendUid']),
                  );
                }).toList()
            )
        )
      ],
    )
    );
  } else{
    return CircularProgressIndicator();
  }


    // return Observer(
    //     builder: (BuildContext context) => CustomScrollView(
    //       slivers: [
    //         CupertinoSliverNavigationBar(
    //           largeTitle: Text("Chats"),
    //         ),
    //         SliverList(
    //             delegate: SliverChildListDelegate(
    //
    //                 chatState.messages.values.toList().map((data) {
    //
    //                   dynamic friendName = data['friendName'][0].toString().toUpperCase() + data['friendName'].toString().substring(1);
    //                   return ListTile(
    //                     leading: CircleAvatar(
    //                       child: Text(friendName[0], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
    //                       radius: 30,
    //                       backgroundColor: Colors.deepOrangeAccent,
    //                     ),
    //                     title: Text(friendName, style: TextStyle(fontWeight: FontWeight.w700),),
    //                     subtitle: Text(data['msg']),
    //                     onTap: () => callChatDetailScreen(
    //                         context, data['friendName'], data['friendUid']),
    //                   );
    //                 }).toList()
    //             )
    //         )
    //       ],
    //     ));
  }
}