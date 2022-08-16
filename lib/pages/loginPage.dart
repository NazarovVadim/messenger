import 'package:chat_app/models/fireAuth.dart';
import 'package:chat_app/models/validator.dart';
import 'package:chat_app/pages/homePage.dart';
import 'package:chat_app/pages/registerPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(

        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return Form(
                key: _formKey,
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                      child: TextFormField(
                        controller: _emailTextController,
                        validator: (value) => Validator.validateEmail(email: value),
                        focusNode: _focusEmail,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                     Padding(
                       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                       child:  TextFormField(
                         controller: _passwordTextController,
                         focusNode: _focusPassword,
                         obscureText: true,
                         validator: (value) => Validator.validatePassword(
                           password: value,
                         ),
                         decoration: InputDecoration(
                           hintText: "Password",
                           errorBorder: UnderlineInputBorder(
                             borderRadius: BorderRadius.circular(6.0),
                             borderSide: BorderSide(
                               color: Colors.red,
                             ),
                           ),
                         ),
                       ),
                     ),
                    SizedBox(height: 24.0),
                    _isProcessing ? CircularProgressIndicator()
                     : Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                ElevatedButton(
                                  onPressed: ()async{
                                    _focusEmail.unfocus();
                                    _focusPassword.unfocus();
                                    if(_formKey.currentState!.validate()){
                                      setState((){
                                        _isProcessing = true;
                                      });
                                      User? user = await FireAuth.signInUsingEmailPassword(
                                          email: _emailTextController.text,
                                          password: _passwordTextController.text
                                      );

                                      setState((){
                                        _isProcessing = false;
                                      });
                                      if (user != null) {
                                        Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>HomePage(user: user),),ModalRoute.withName('/homePage'),);
                                      }

                                    }






                                  },
                                  child: const Text('Sign In', style: TextStyle(color: Colors.white),),)
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Don\'t have an account?', style: TextStyle(color: Colors.black54),),
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(
                                        builder: (context) => const RegisterPage(),
                                      ),
                                    );
                                  }, child: const Text('Register'))
                                ],
                              )
                          ],
                        ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
