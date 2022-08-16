
import 'package:chat_app/pages/chatsPage.dart';
import 'package:chat_app/pages/peoplePage.dart';
import 'package:chat_app/pages/settingsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key,}) : super(key: key);

  final User user;

  const HomePage({required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentTabIndex = 0;
  late User _currentUser;

  @override
  void initState() {
    //NewMessageState.isNewMessage = false;
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final tabPages = <Widget>[
      Center(child: ChatsPage(user: _currentUser)),
      //const Center(child: Icon(Icons.phone),),
      Center(child: PeoplePage(user: _currentUser),),
      Center(child: SettingsPage(user: _currentUser)),
    ];

    final bottomNavBarItems = [
      BottomNavigationBarItem(icon: (currentTabIndex==0) ? const Icon(Icons.message,) : const Icon(Icons.message_outlined), label: 'Chats'),
      //BottomNavigationBarItem(icon: (currentTabIndex==1) ? const Icon(Icons.phone) : const Icon(Icons.phone), label: 'Calls'),
      BottomNavigationBarItem(icon: (currentTabIndex==2) ? const Icon(Icons.person) : const Icon(Icons.person_outline_rounded), label: 'People'),
      BottomNavigationBarItem(icon: (currentTabIndex==3) ? const Icon(Icons.settings) : const Icon(Icons.settings_outlined), label: 'Settings'),
    ];


    return Scaffold(
      body: tabPages[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState((){
            currentTabIndex = index;
          });
        },
      ),
    );

    // return CupertinoPageScaffold(
    //     child: CupertinoTabScaffold(
    //       resizeToAvoidBottomInset: true,
    //       tabBar: CupertinoTabBar(
    //         onTap: (index){
    //           setState((){
    //             currentTabIndex = index;
    //           });
    //         },
    //         items: bottomNavBarItems,
    //       ), tabBuilder: (BuildContext context, int index) {
    //         return Container(child: Center(child: tabPages[index], ),);
    //     },
    //     ),
    // );
  }
}
