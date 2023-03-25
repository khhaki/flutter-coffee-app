import 'package:app/models/user.dart';
import 'package:app/services/database.dart';
import 'package:app/shared/constant.dart';
import 'package:app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settingsform extends StatefulWidget {
  const Settingsform({Key? key}) : super(key: key);

  @override
  _SettingsformState createState() => _SettingsformState();
}

class _SettingsformState extends State<Settingsform> {
  final _formkey = GlobalKey<FormState>();

  String _currentname = 'name';
  String _currentsugar = '0';
  int _currentstrength = 100;
  final List<String> sugars = ['0', '1', '2', '3'];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Mosta?>(context);
    return StreamBuilder<UserData>(
      stream: Databaseser(uid: user!.uid).userData,
      builder: (context, snapshot) {
        UserData? userData = snapshot.data;
        if (snapshot.hasData) {
          return Form(
            key: _formkey,
            child: Column(
              children: [
                Text(
                  'update your brew settings',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue:
                      _currentname == 'name' ? userData!.name : _currentname,
                  decoration: textinputdec,
                  validator: (val) =>
                      val!.isEmpty ? 'please entre a name' : null,
                  onChanged: (val) => setState(() => _currentname = val),
                ),
                SizedBox(
                  height: 20,
                ),
                //dropdown

                DropdownButtonFormField(
                  value:
                      _currentsugar == '0' ? userData!.sugars : _currentsugar,
                  decoration: textinputdec,
                  onChanged: (val) {
                    setState(() => _currentsugar = val.toString());
                    // print(_currentsugar);
                  },
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      child: Text("$sugar sugars"),
                      value: sugar,
                    );
                  }).toList(),
                ),

                SizedBox(
                  height: 20,
                ),
                //slider
                Slider(
                  value: (_currentstrength).toDouble(),
                  activeColor: Colors.brown[_currentstrength],
                  inactiveColor: Colors.brown[_currentstrength],
                  onChanged: (val) =>
                      setState(() => _currentstrength = val.round()),
                  min: 100,
                  max: 900,
                  divisions: 8,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await Databaseser(uid: user.uid).updateuserData(
                          _currentsugar, _currentname, _currentstrength);
                      Navigator.pop(context);
                    }
                    print(_currentname);
                    print(_currentsugar);
                    print(_currentstrength);
                  },
                  child: Text(
                    'update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400]),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
