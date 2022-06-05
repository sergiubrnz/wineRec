import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/components/profile_card.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../../utils/Storage/user_preferences.dart';
import '../../blocs/firebase_bloc/firebase_lists_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var name = '';
  var imageUrl = '';
  var uid = '';

  void getData() async {
    final nume = await SecureStorage.getUserName();
    final image = await SecureStorage.getUserImage();
    final userID = await SecureStorage.getUID();
    print(image);
    setState(() {
      name = nume!;
      imageUrl = image!;
      uid = userID!;
    });
    await getLists(context, userID!);
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
        imageUrl: imageUrl.isEmpty
            ? 'https://firebasestorage.googleapis.com/v0/b/winerecs-d0f6d.appspot.com/o/profilePics%2FrzrbTG1yaoeKdFeJIWJMHKDkxcv2?alt=media&token=e7abc1df-596b-462b-b3be-94c45e63e265'
            : imageUrl,
      ),
    );
  }

  int getLists(BuildContext context, String userId) {
    final basketBloc = context.read<FirebaseListsBloc>();
    basketBloc.add(GetFirebaseLists(userId));
    return 1;
  }
}
