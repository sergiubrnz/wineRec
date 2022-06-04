import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/ui/components/profile_card.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../../utils/Storage/user_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var name = '';
  var imageUrl = '';

  void getData() async {
    final nume = await SecureStorage.getUserName();
    final image = await SecureStorage.getUserImage();
    print(image);
    setState(() {
      name = nume!;
      imageUrl = image!;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getData();
    });
  }

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
      body: ProfileCard(
        name: name,
        imageUrl: imageUrl,
      ),
    );
  }
}
