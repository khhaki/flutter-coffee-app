import 'dart:ui';

import 'package:app/services/auth.dart';
import 'package:app/shared/constant.dart';
import 'package:app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function togglev;
  SignIn({required this.togglev});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String passw = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.togglev();
                    },
                    icon: Icon(Icons.person),
                    label: Text('register'))
              ],
              backgroundColor: Colors.brown[400],
              title: Text('sign in'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textinputdec.copyWith(hintText: 'email'),
                        validator: (val) =>
                            val!.isEmpty ? 'enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textinputdec.copyWith(hintText: 'password'),
                        validator: (val) => val!.length < 6
                            ? 'enter a pass 6+ chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            passw = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth.signinE(email, passw);
                            if (result == null) {
                              setState(() {
                                error = 'could not sign in';
                                loading = false;
                              });
                            }
                          }
                          ;
                        },
                        child: Text(
                          'sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.pink)),
                      ),
                      SizedBox(height: 12),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
