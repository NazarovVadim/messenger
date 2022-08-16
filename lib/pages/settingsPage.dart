import 'package:chat_app/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  // const SettingsPage({Key? key,}) : super(key: key);

  final User user;

  const SettingsPage({required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.deepOrangeAccent,
                          child: Text(_currentUser.displayName![0].toUpperCase(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                        ),
                        const SizedBox(width: 50,),
                        Text(
                          _currentUser.displayName![0].toUpperCase() + _currentUser.displayName!.substring(1),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black87),
                        )
                      ],
                    ),
                  )
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Logout', style: TextStyle(fontSize: 20, color: Colors.black87),),
                        IconButton(
                            onPressed: () async{
                              await FirebaseAuth.instance.signOut();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );



                            },
                            icon: const Icon(CupertinoIcons.square_arrow_right), color: Colors.redAccent,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        )
    );
  }
}
