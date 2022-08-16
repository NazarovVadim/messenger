import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatefulWidget {

  final User user;

  const PeoplePage({required this.user});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').where('uid', isNotEqualTo: currentUser).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text('Something went wrong.'),
          );
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.hasData){
          var data = snapshot.data?.docs.toList();



          return Scaffold(
            appBar: AppBar(
              title: Text('Chats'),
            ),
            body: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  var cur = data![index].data().toString().split(',')[2].substring(7);
                  var name = cur[0].toUpperCase() + cur.substring(1);
                  index++;
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepOrangeAccent,
                        child: Text('${name[0]}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                      ),
                      title: Text('${name}'),
                      subtitle: const Text('Message'),
                      // onTap: (){
                      //   MessageUser.targetUser = dialogsName[index];
                      //   Navigator.push(context,  MaterialPageRoute( builder: (context) => const MessagePage(),));
                      // },
                    ),
                  );
                },

            ),
          );
        }
        return Center();
      },
    );
  }
}
