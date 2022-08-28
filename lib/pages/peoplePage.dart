
import 'package:chat_app/states/users_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/states/lib.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dialogPage.dart';


class PeoplePage extends StatelessWidget {
  PeoplePage({Key? key}) : super(key: key);
  var currentUser = FirebaseAuth.instance.currentUser?.uid;

  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DialogPage(recipientUid: uid, recipientName: name)));
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text("People"),
        ),
        SliverToBoxAdapter(
          key: UniqueKey(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CupertinoSearchTextField(
              onChanged: (value) => usersState.setSearchTerm(value),
              onSubmitted: (value) => usersState.setSearchTerm(value),
            ),
          ),
        ),
        Observer(
          builder: (_) => SliverList(
            delegate: SliverChildListDelegate(
              usersState.people
                  .map(
                    (dynamic data) => CupertinoListTile(
                  // leading: CircleAvatar(
                  //   radius: 30,
                  //   //backgroundImage: NetworkImage(data['picture'] != null ? data['picture'] : ''),
                  //   backgroundColor: Colors.deepOrangeAccent,
                  // ),
                  onTap: () {
                    //print(data['uid']);
                    callChatDetailScreen(
                        context,
                        data['name'] != null ? data['name'] : '',
                        data['uid']
                    );
                  },
                  title: Text(data['name'] != null ? data['name'][0].toUpperCase() + data['name'].substring(1) : ''),
                  subtitle:
                  Text(data['status'] != null ? data['status'] : ''),
                ),
              )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}


