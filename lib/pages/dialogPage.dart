import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {

  final User user;
  final String recipient;


  const DialogPage({required this.user, required this.recipient});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  late String recipientName;
  late User _currentUser;

  var name;

  @override
  void initState(){
    recipientName = widget.recipient;
    _currentUser = widget.user;
    name = recipientName.split(',')[2].substring(7);
    name = name[0].toUpperCase() + name.substring(1);
    super.initState();

  }

  //var name = recipientName.split(',')[2].substring(7);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
    );
  }
}
