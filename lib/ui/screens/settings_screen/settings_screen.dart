import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/utils/colours.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Setari"),
      ),
      body: Center(
        child: Text('SETTINGS'),
      ),
    );
  }
}
