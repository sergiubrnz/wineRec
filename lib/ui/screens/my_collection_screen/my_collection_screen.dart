import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/colours.dart';

class MyCollectionScreen extends StatefulWidget {
  const MyCollectionScreen({Key? key}) : super(key: key);

  @override
  State<MyCollectionScreen> createState() => _MyCollectionScreenState();
}

class _MyCollectionScreenState extends State<MyCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Vinurile mele"),
      ),
      body: Center(
        child: Text('MY_COLLECTION'),
      ),
    );
  }
}
