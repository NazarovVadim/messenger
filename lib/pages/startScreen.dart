import 'package:chat_app/pages/loginPage.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  void initState(){
    Future?.delayed(const Duration(seconds: 2)).then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>LoginPage(),),ModalRoute.withName('/homePage'),));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Welcome to', style: TextStyle(fontSize: 30),),
            Text('The Chat App', style: TextStyle(fontSize: 36, color: Colors.deepOrange, fontWeight: FontWeight.w700),),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
