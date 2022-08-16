
import 'package:chat_app/pages/peoplePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  final User user;


  const ChatsPage({required this.user});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  var currentUser = FirebaseAuth.instance.currentUser?.uid;

  late User _currentUser;
  late int index = 0;

  @override
  void initState() {
    _currentUser = widget.user;
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if(!NewMessageState.isNewMessage){
      //       NewMessageState.isNewMessage = true;
      //       Navigator.push(context,  MaterialPageRoute( builder: (context) => PeoplePage(user: _currentUser),));
      //     }
      //   },
      //   child: const Icon(CupertinoIcons.add),
      // ),
    );
  }
}
