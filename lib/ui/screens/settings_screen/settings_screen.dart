import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/components/profile_card.dart';
import 'package:wine_rec/utils/colours.dart';

import '../../../firebase/user_methods.dart';
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
  bool _isLoading = false;

  void getData() async {
    setState(() {
      _isLoading = true;
    });
    final userID = await SecureStorage.getUID();

    var res = (await UserMethods().getUserInfo(
      uid: userID!,
    ));

    var lists = await getLists(context, userID);

    setState(() {
      name = res!['prenume'];
      imageUrl = res['photoUrl'];
      _isLoading = false;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Setari"),
      ),
      body: Stack(children: [
        ProfileCard(
          name: name,
          imageUrl: imageUrl.isEmpty
              ? 'https://firebasestorage.googleapis.com/v0/b/winerecs-d0f6d.appspot.com/o/profilePics%2FrzrbTG1yaoeKdFeJIWJMHKDkxcv2?alt=media&token=e7abc1df-596b-462b-b3be-94c45e63e265'
              : imageUrl,
        ),
        _isLoading
            ? Container(
                height: size.height,
                width: size.width,
                color: Colors.transparent,
                child: const Center(
                  child: SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                        strokeWidth: 5.0),
                  ),
                ),
              )
            : Container(),
      ]),
    );
  }

  int getLists(BuildContext context, String userId) {
    final basketBloc = context.read<FirebaseListsBloc>();
    basketBloc.add(GetFirebaseLists(userId));
    return 1;
  }
}
