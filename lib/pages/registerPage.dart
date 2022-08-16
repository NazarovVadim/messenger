import 'package:chat_app/models/fireAuth.dart';
import 'package:chat_app/pages/homePage.dart';
import 'package:chat_app/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(

        body: Padding(
          padding: EdgeInsets.all(40),
          child: Center(
            child: Column(
              children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) => Validator.validateName(name: value),
                        decoration: InputDecoration(
                          hintText: "Username",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(email: value,),
                        decoration: InputDecoration(
                          hintText: "Email",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
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
                      SizedBox(height: 32.0),
                      _isProcessing ? CircularProgressIndicator()
                          : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                ElevatedButton(
                                  onPressed: ()async{


                                    if(_registerFormKey.currentState!.validate()){
                                      setState(() {
                                        _isProcessing = true;
                                      });
                                      User? user = await FireAuth.registerUsingEmailPassword(
                                          name: _nameTextController.text,
                                          email: _emailTextController.text,
                                          password: _passwordTextController.text);

                                      setState((){
                                        _isProcessing = false;
                                      });

                                      if (user != null) {
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>HomePage(user: user),),ModalRoute.withName('/homePage'),);
                                      }

                                    }
                                  },
                                  child: const Text('Sign Up', style: TextStyle(color: Colors.white),),)
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Already have an account?', style: TextStyle(color: Colors.black54),),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                }, child: const Text('Sign In'))
                              ],
                            )
                          ],
                        ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
