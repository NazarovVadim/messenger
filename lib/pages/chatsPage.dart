import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/pages/dialogPage.dart';
import 'package:chat_app/states/lib.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {

  @override
  void initState() {
    super.initState();
    chatState.refreshChatsForCurrentUser();
  }

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DialogPage(recipientUid: uid, recipientName: name)));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (BuildContext context) => CustomScrollView(
          slivers: [
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Chats"),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
                  chatState.messages.values.toList().map((data) {
                    return Observer(
                      builder: (_) =>
                          CupertinoListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.deepOrangeAccent,
                              child: Text(data['friendName'][0].toString().toUpperCase(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                              // backgroundImage: NetworkImage(
                              //     usersState.users[data['friendUid']]['picture'] !=
                              //         null
                              //         ? usersState.users[data['friendUid']]['picture']
                              //         : ''),

                            ),
                            onTap: () {
                              print(data);
                              callChatDetailScreen(
                                  context,
                                  usersState.users[data['friendUid']]['name'] != null
                                  ? usersState.users[data['friendUid']]['name']
                                      : '',
                                  data['friendUid']);
                            },
                            title: Text(
                                usersState.users[data['friendUid']]['name'] != null
                                    ? usersState.users[data['friendUid']]['name'][0].toUpperCase() + usersState.users[data['friendUid']]['name'].substring(1)
                                    : ''
                            ),
                            subtitle: Text(
                                // usersState.users[data['friendUid']]['status'] != null
                                //     ? usersState.users[data['friendUid']]['status']
                                //     : ''
                                data['msg']
                            ),


                          ),
                    );

                    //   return CupertinoListTile(
                    //     title: Text(data['friendName']),
                    //     subtitle: Text(data['msg']),
                    //     onTap: () => callChatDetailScreen(
                    //         context, data['friendName'], data['friendUid']),
                    //   );
                  }).toList()))
          ],
        ));
  }
}