import 'package:app/models/brew.dart';
import 'package:app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class Hakolist extends StatefulWidget {
  @override
  _HakolistState createState() => _HakolistState();
}

class _HakolistState extends State<Hakolist> {
  @override
  Widget build(BuildContext context) {
    final hak = Provider.of<List<Brew>?>(context);
    if (hak == null) {
      return Loading();
    } else {
      hak.forEach((brew) {
        print(brew.name);
        print(brew.sugar);
        print(brew.strength);
      });

      return ListView.builder(
        itemBuilder: (context, index) {
          return Brewtile(brew: hak[index]);
        },
        itemCount: hak.length,
      );
    }
  }
}
