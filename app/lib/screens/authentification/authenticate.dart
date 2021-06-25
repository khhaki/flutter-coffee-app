import 'package:app/screens/authentification/registre.dart';
import 'package:app/screens/authentification/sign_in.dart';
import 'package:flutter/material.dart';

class Athenticate extends StatefulWidget {
  const Athenticate({Key? key}) : super(key: key);

  @override
  _AthenticateState createState() => _AthenticateState();
}

class _AthenticateState extends State<Athenticate> {
  bool show = true;
  void togglev() {
    setState(() => show = !show);
  }

  @override
  Widget build(BuildContext context) {
    return show == true ? SignIn(togglev: togglev) : Register(togglev: togglev);
  }
}
