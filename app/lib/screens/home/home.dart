import 'dart:ui';

import 'package:app/models/brew.dart';
import 'package:app/screens/home/hk_list.dart';
import 'package:app/screens/home/settings_form.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/database.dart';
import 'package:app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showset() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Settingsform(),
            );
          });
    }

    return MultiProvider(
        providers: [
          StreamProvider<List<Brew>?>(
            create: (_) => Databaseser().hakos,
            initialData: null,
          )
        ],
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text(
              'coffee',
              style: TextStyle(color: Colors.brown[900]),
            ),
            backgroundColor: Colors.brown[400],
            elevation: 10,
            actions: [
              TextButton.icon(
                onPressed: () async {
                  await _auth.signO();
                },
                icon: Icon(Icons.person),
                label: Text("log out"),
              ),
              TextButton.icon(
                  onPressed: () => _showset(),
                  icon: Icon(Icons.settings),
                  label: Text('settings'))
            ],
          ),
          body: Container(
            child: Hakolist(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee.jpg'), fit: BoxFit.cover),
            ),
          ),
        ));
  }
}
