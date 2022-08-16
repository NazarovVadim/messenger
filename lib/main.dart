import 'package:chat_app/pages/homePage.dart';
import 'package:chat_app/pages/loginPage.dart';
import 'package:chat_app/pages/startScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){

  User user;

  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.light),

    home: const StartScreen(),
  ));


}

