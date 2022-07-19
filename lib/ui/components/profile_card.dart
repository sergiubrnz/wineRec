import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wine_rec/ui/components/settings_widget_card.dart';
import 'package:wine_rec/ui/screens/login_screen/login_screen.dart';
import 'package:wine_rec/ui/screens/profile_screen/profile_screen.dart';
import 'package:wine_rec/utils/Storage/user_preferences.dart';
import 'package:wine_rec/utils/colours.dart';

import '../blocs/firebase_bloc/firebase_lists_bloc.dart';

class ProfileCard extends StatelessWidget {
  void logoutUser() async {
    await SecureStorage.deleteAllData();
  }

  final String? name;
  final String? imageUrl;

  ProfileCard({
    Key? key,
    this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.6,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: size.width * 0.2,
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              name!,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: 'AdobeGaramond',
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.6,
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Divider(
                                  thickness: 2,
                                  height: 15,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            SettingsWidgetCard(
                              text: 'Editare cont ',
                              rightIcon: IconButton(
                                icon: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ProfileScreen();
                                      },
                                    ),
                                  )
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                print(state.toString());
                                if (state is ListsLoaded) {
                                  return SettingsWidgetCard(
                                    text: 'Colectia mea ',
                                    rightIcon: IconButton(
                                      icon: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          state.collection.length.toString(),
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      onPressed: () => {},
                                    ),
                                  );
                                } else {
                                  return SettingsWidgetCard(
                                    text: 'Colectia mea ',
                                    rightIcon: IconButton(
                                      icon: const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '0',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      onPressed: () => {},
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BlocConsumer<FirebaseListsBloc, FirebaseListsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is ListsLoaded) {
                                  return SettingsWidgetCard(
                                    text: 'Aprecierile mele ',
                                    rightIcon: IconButton(
                                      icon: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          state.likes.length.toString(),
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      onPressed: () => {},
                                    ),
                                  );
                                } else {
                                  return SettingsWidgetCard(
                                    text: 'Aprecierile mele ',
                                    rightIcon: IconButton(
                                      icon: const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '0',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      onPressed: () => {},
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 100,
                    backgroundImage: NetworkImage(imageUrl!),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.05,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0))),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Delogare",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                onPressed: () {
                  logoutUser();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
