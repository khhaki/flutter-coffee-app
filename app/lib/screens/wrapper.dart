import 'package:app/models/user.dart';
import 'package:app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentification/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Mosta?>(context);
    return user == null ? Athenticate() : Home();
  }
}
